#!/usr/bin/env bash

set -euo pipefail

KLIPPER_DIR="${KLIPPER_DIR:-$HOME/klipper}"
KLIPPY_ENV="${KLIPPY_ENV:-$HOME/klippy-env}"
CARTOGRAPHER_FIRMWARE_DIR="${CARTOGRAPHER_FIRMWARE_DIR:-$HOME/cartographer_firmware}"
KLIPPER_REPO="${KLIPPER_REPO:-https://github.com/pellcorp/klipper}"
CARTOGRAPHER_FIRMWARE_REPO="${CARTOGRAPHER_FIRMWARE_REPO:-https://github.com/Cartographer3D/cartographer_firmware}"
REPORT_BASE_URL="${REPORT_BASE_URL:-https://api.cartographer3d.com/report}"
SERIAL_GLOB="${SERIAL_GLOB:-/dev/serial/by-id/usb-*}"
BOOTLOADER_GLOB="${BOOTLOADER_GLOB:-/dev/serial/by-id/usb-katapult*}"
WAIT_TIMEOUT="${WAIT_TIMEOUT:-60}"
POLL_INTERVAL="${POLL_INTERVAL:-1}"
MODEL="${MODEL:-}"
FLASH_METHOD="${FLASH_METHOD:-katapult}"
SEND_USAGE_REPORT="${SEND_USAGE_REPORT:-ask}"
APT_LOCK_RETRY_SECONDS="${APT_LOCK_RETRY_SECONDS:-10}"
APT_LOCK_MAX_RETRIES="${APT_LOCK_MAX_RETRIES:-18}"
PYTHON_BIN=""
APT_UPDATED=0

usage() {
    cat <<'EOF'
Usage: cartographer_flash.sh [--model v3|v4] [--timeout seconds] [--dfu|--katapult]

Automates Cartographer flashing on Ubuntu 24.04+ by:
1. Installing apt dependencies.
2. Installing Python 3.12 via deadsnakes if the default python3 is newer.
3. Cloning or updating Klipper and cartographer_firmware.
4. Creating or rebuilding ~/klippy-env with Python 3.12.
5. Flashing via Katapult or DFU mode.
6. Waiting for the Cartographer USB device to reconnect.

Options:
  --model v3|v4    Force the model if auto-detect is ambiguous.
  --dfu            Flash using dfu-util and the combined DFU firmware.
  --katapult       Flash using the default Katapult/flash_can flow.
  --timeout N      Wait timeout in seconds for reconnect steps. Default: 60
  --help           Show this help text.

Environment overrides:
  KLIPPER_DIR                  Default: $HOME/klipper
  KLIPPY_ENV                   Default: $HOME/klippy-env
  CARTOGRAPHER_FIRMWARE_DIR    Default: $HOME/cartographer_firmware
  KLIPPER_REPO                 Default: https://github.com/pellcorp/klipper
  CARTOGRAPHER_FIRMWARE_REPO   Default: https://github.com/Cartographer3D/cartographer_firmware
  REPORT_BASE_URL              Default: https://api.cartographer3d.com/report
  FLASH_METHOD                 katapult | dfu, default: katapult
  SEND_USAGE_REPORT            ask | yes | no, default: ask
  APT_LOCK_RETRY_SECONDS       Default: 10
  APT_LOCK_MAX_RETRIES         Default: 18
  SERIAL_GLOB                  Default: /dev/serial/by-id/usb-*
  BOOTLOADER_GLOB              Default: /dev/serial/by-id/usb-katapult*
  WAIT_TIMEOUT                 Default: 60
EOF
}

log() {
    printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*"
}

die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

require_path() {
    local path="$1"
    local description="$2"
    [[ -e "$path" ]] || die "$description not found: $path"
}

run_sudo() {
    sudo "$@"
}

run_quiet_command() {
    local description="$1"
    shift
    local output=""
    local status=0

    set +e
    output=$("$@" 2>&1)
    status=$?
    set -e

    if (( status != 0 )); then
        printf '%s\n' "$output" >&2
        die "$description failed"
    fi
}

run_apt_command() {
    local attempt=1
    local output=""
    local status=0

    while (( attempt <= APT_LOCK_MAX_RETRIES )); do
        set +e
        output=$(run_sudo "$@" 2>&1)
        status=$?
        set -e

        if (( status == 0 )); then
            return 0
        fi

        if grep -q "Could not get lock /var/lib/dpkg/lock-frontend" <<<"$output"; then
            log "apt is waiting on dpkg lock, retry $attempt/$APT_LOCK_MAX_RETRIES in ${APT_LOCK_RETRY_SECONDS}s"
            if (( attempt == APT_LOCK_MAX_RETRIES )); then
                printf '%s\n' "$output" >&2
                die "Unable to acquire the dpkg lock after $APT_LOCK_MAX_RETRIES attempts"
            fi
            sleep "$APT_LOCK_RETRY_SECONDS"
            ((attempt++))
            continue
        fi

        printf '%s\n' "$output" >&2
        return "$status"
    done
}

list_matches() {
    local pattern="$1"
    compgen -G "$pattern" || true
}

first_match() {
    local pattern="$1"
    list_matches "$pattern" | head -n 1
}

device_name_from_serial_path() {
    local serial_path="$1"
    if [[ "$serial_path" =~ /dev/serial/by-id/([^[:space:]]+) ]]; then
        printf '%s\n' "${BASH_REMATCH[1]}"
        return 0
    fi
    basename "$serial_path"
}

find_cartographer_device() {
    list_matches "$SERIAL_GLOB" | grep -E 'IDM|Cartographer' | head -n 1 || true
}

wait_for_absent() {
    local path="$1"
    local timeout="$2"
    local start
    start=$(date +%s)

    while [[ -e "$path" ]]; do
        if (( $(date +%s) - start >= timeout )); then
            die "Timed out waiting for device to disappear: $path"
        fi
        sleep "$POLL_INTERVAL"
    done
}

wait_for_match() {
    local pattern="$1"
    local timeout="$2"
    local start
    local match
    start=$(date +%s)

    while true; do
        match=$(first_match "$pattern")
        if [[ -n "$match" ]]; then
            printf '%s\n' "$match"
            return 0
        fi
        if (( $(date +%s) - start >= timeout )); then
            die "Timed out waiting for device matching: $pattern"
        fi
        sleep "$POLL_INTERVAL"
    done
}

wait_for_cartographer_device() {
    local timeout="$1"
    local start
    local match
    start=$(date +%s)

    while true; do
        match=$(find_cartographer_device)
        if [[ -n "$match" ]]; then
            printf '%s\n' "$match"
            return 0
        fi
        if (( $(date +%s) - start >= timeout )); then
            die "Timed out waiting for Cartographer serial device to return"
        fi
        sleep "$POLL_INTERVAL"
    done
}

infer_model_from_serial() {
    local serial_path="$1"
    local serial_base
    serial_base=$(basename "$serial_path")

    case "$serial_base" in
        *stm32g431*|*STM32G431*)
            printf 'v4\n'
            ;;
        *)
            printf 'v3\n'
            ;;
    esac
}

firmware_path_for_model() {
    local model="$1"

    case "$model" in
        v3)
            printf '%s\n' "$CARTOGRAPHER_FIRMWARE_DIR/firmware/v2-v3/survey/5.0.0/Survey_Cartographer_K1_USB_8kib_offset.bin"
            ;;
        v4)
            printf '%s\n' "$CARTOGRAPHER_FIRMWARE_DIR/firmware/v4/firmware/6.0.0/CartographerV4_6.0.0_USB_lite_8kib_offset.bin"
            ;;
        *)
            die "Unsupported model: $model"
            ;;
    esac
}

dfu_firmware_path_for_model() {
    local model="$1"

    case "$model" in
        v3)
            printf '%s\n' "$CARTOGRAPHER_FIRMWARE_DIR/firmware/v2-v3/combined-firmware/5.0.0/Full_Survey_Cartographer_CrealityK1_USB_5_0_0.bin"
            ;;
        v4)
            printf '%s\n' "$CARTOGRAPHER_FIRMWARE_DIR/firmware/v4/combined-firmware/6.0.0/Katapult_plus_CartographerV4_6.0.0__USB_lite.bin"
            ;;
        *)
            die "Unsupported model: $model"
            ;;
    esac
}

firmware_version_for_model() {
    case "$1" in
        v3) printf '5.0.0\n' ;;
        v4) printf '6.0.0\n' ;;
        *) printf 'unknown\n' ;;
    esac
}

firmware_flavour_for_model() {
    case "$1" in
        v4) printf 'Lite\n' ;;
        v3) printf 'Lite\n' ;;
        *) printf 'Full\n' ;;
    esac
}

ensure_apt_update() {
    if (( APT_UPDATED == 0 )); then
        log "Running apt-get update"
        run_apt_command apt-get update
        APT_UPDATED=1
    fi
}

install_base_packages() {
    ensure_apt_update
    log "Installing Ubuntu dependencies"
    run_apt_command apt-get install -y \
        virtualenv \
        python3-dev \
        python3-pip \
        python3-setuptools \
        libffi-dev \
        software-properties-common \
        build-essential \
        curl \
        git \
        dfu-util
}

python_major_minor() {
    "$1" -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")'
}

python_newer_than_312() {
    local version="$1"
    local major="${version%%.*}"
    local minor="${version#*.}"

    if (( major > 3 )); then
        return 0
    fi
    if (( major == 3 && minor > 12 )); then
        return 0
    fi
    return 1
}

ensure_python312() {
    local default_python="${PYTHON_BIN:-$(command -v python3)}"
    local default_version
    local python312_bin=""

    require_command python3
    default_version=$(python_major_minor "$default_python")
    log "Default python3 version is $default_version"

    if python_newer_than_312 "$default_version"; then
        python312_bin="$(command -v python3.12 || true)"
        if [[ -n "$python312_bin" ]]; then
            log "python3.12 is already available, skipping deadsnakes setup"
            PYTHON_BIN="$python312_bin"
        else
            log "Default python3 is newer than 3.12, installing python3.12 from deadsnakes"
            ensure_apt_update
            run_apt_command add-apt-repository -y ppa:deadsnakes/ppa
            APT_UPDATED=0
            ensure_apt_update
            run_apt_command apt-get install -y python3.12 python3.12-dev
            PYTHON_BIN="$(command -v python3.12)"
        fi
        [[ -n "$PYTHON_BIN" ]] || die "python3.12 was installed but not found in PATH"
    else
        PYTHON_BIN="$default_python"
    fi

    log "Using Python interpreter: $PYTHON_BIN"
}

clone_or_update_repo() {
    local repo_url="$1"
    local target_dir="$2"
    local branch="${3:-main}"
    local current_origin=""

    if [[ ! -d "$target_dir/.git" ]]; then
        log "Cloning $repo_url into $target_dir"
        git clone "$repo_url" "$target_dir"
        return 0
    fi

    current_origin="$(git -C "$target_dir" remote get-url origin 2>/dev/null || true)"
    [[ -n "$current_origin" ]] || die "Repository exists but has no origin remote: $target_dir"
    if [[ "$current_origin" != "$repo_url" ]]; then
        die "Repository origin does not match expected remote for $target_dir: expected $repo_url, found $current_origin"
    fi

    log "Updating repository in $target_dir"
    if [[ -n "$(git -C "$target_dir" status --short 2>/dev/null)" ]]; then
        die "Repository has local changes, refusing to update automatically: $target_dir"
    fi
    git -C "$target_dir" fetch origin
    git -C "$target_dir" switch "$branch"
    git -C "$target_dir" pull --ff-only origin "$branch"
}

env_python_major_minor() {
    local env_dir="$1"
    "$env_dir/bin/python" -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")'
}

ensure_klippy_env() {
    local env_version=""

    require_path "$KLIPPER_DIR/scripts/klippy-requirements.txt" "Klipper requirements file"
    require_command virtualenv

    if [[ -x "$KLIPPY_ENV/bin/python" ]]; then
        env_version=$(env_python_major_minor "$KLIPPY_ENV")
        if [[ "$env_version" != "3.12" ]]; then
            log "Existing klippy env uses Python $env_version, rebuilding with Python 3.12"
            rm -rf "$KLIPPY_ENV"
        fi
    fi

    if [[ ! -x "$KLIPPY_ENV/bin/python" ]]; then
        log "Creating klippy env at $KLIPPY_ENV"
        run_quiet_command "virtualenv creation" \
            virtualenv -p "$PYTHON_BIN" --system-site-packages "$KLIPPY_ENV"
    fi

    log "Installing klippy env packages"
    run_quiet_command "pip bootstrap install" \
        "$KLIPPY_ENV/bin/pip3" install -q -U pip wheel setuptools
    run_quiet_command "klippy requirements install" \
        "$KLIPPY_ENV/bin/pip3" install -q -r "$KLIPPER_DIR/scripts/klippy-requirements.txt"
}

bootstrap_environment() {
    require_command sudo

    install_base_packages
    require_command curl
    require_command git
    ensure_python312
    clone_or_update_repo "$KLIPPER_REPO" "$KLIPPER_DIR" "master"
    clone_or_update_repo "$CARTOGRAPHER_FIRMWARE_REPO" "$CARTOGRAPHER_FIRMWARE_DIR" "main"
    ensure_klippy_env
}

print_usage_report_preview() {
    local protocol="$1"
    local probe_version="$2"
    local identifier="$3"
    local firmware_version="$4"
    local flavour="$5"

    printf '%s\n' "Optional anonymous usage report:"
    printf '%s\n' "  This helps Cartographer3D estimate how many probes are in use and which firmware, link type, and build are common."
    printf '%s\n' "  No personal information is sent."
    printf '%s\n' "  Fields sent:"
    printf '%s\n' "    protocol:      $protocol"
    printf '%s\n' "    probe_version: $probe_version"
    printf '%s\n' "    identifier:    $identifier"
    printf '%s\n' "    firmware:      $firmware_version"
    printf '%s\n' "    flavour:       $flavour"
}

send_usage_report() {
    local carto_dev="$1"
    local model="$2"
    local identifier
    local firmware_version
    local flavour
    local choice="$SEND_USAGE_REPORT"

    identifier=$(device_name_from_serial_path "$carto_dev")
    [[ -n "$identifier" ]] || return 0

    firmware_version=$(firmware_version_for_model "$model")
    flavour=$(firmware_flavour_for_model "$model")

    if [[ "$choice" == "ask" ]]; then
        if [[ -t 0 && -t 1 ]]; then
            print_usage_report_preview "USB" "$model" "$identifier" "$firmware_version" "$flavour"
            printf '%s\n' "Send anonymous report?"
            printf '%s\n' "  1 - Send the report above"
            printf '%s\n' "  2 - Do not send"
            while true; do
                read -r -p "Enter 1 or 2: " choice || true
                choice="$(printf '%s' "$choice" | tr -d '[:space:]')"
                case "$choice" in
                    1) choice="yes"; break ;;
                    2) choice="no"; break ;;
                    *) ;;
                esac
            done
        else
            log "Skipping anonymous usage report prompt because this is not an interactive terminal"
            return 0
        fi
    fi

    case "$choice" in
        yes)
            if curl -sS -f -G "$REPORT_BASE_URL" \
                --data-urlencode "protocol=USB" \
                --data-urlencode "identifier=$identifier" \
                --data-urlencode "firmware=$firmware_version" \
                --data-urlencode "flavour=$flavour" \
                --data-urlencode "probe_version=$model" \
                -o /dev/null; then
                log "Anonymous usage report sent"
            else
                log "Anonymous usage report could not be sent"
            fi
            ;;
        no)
            log "Anonymous usage report not sent"
            ;;
        *)
            die "Invalid SEND_USAGE_REPORT value: $choice"
            ;;
    esac
}

wait_for_dfu_device() {
    local timeout="$1"
    local start
    local output=""
    local status=0
    start=$(date +%s)

    while true; do
        set +e
        output=$(run_sudo dfu-util -l 2>&1)
        status=$?
        set -e

        if (( status == 0 )) && grep -q "Found DFU:" <<<"$output"; then
            return 0
        fi
        if (( $(date +%s) - start >= timeout )); then
            printf '%s\n' "$output" >&2
            die "Timed out waiting for a DFU device. Verify the boot pins are bridged before USB is connected."
        fi
        sleep "$POLL_INTERVAL"
    done
}

run_enter_bootloader() {
    local carto_dev="$1"
    local python_bin="$KLIPPY_ENV/bin/python"
    local flash_usb_dir="$KLIPPER_DIR/scripts"

    require_path "$python_bin" "Klippy Python interpreter"
    require_path "$flash_usb_dir/flash_usb.py" "Klipper flash_usb helper"

    log "Requesting bootloader mode on $carto_dev"
    (
        cd "$flash_usb_dir"
        run_sudo "$python_bin" -c "import flash_usb as u; u.enter_bootloader('$carto_dev')"
    )
}

run_flash() {
    local firmware_path="$1"
    local katapult_dev="$2"
    local python_bin="$KLIPPY_ENV/bin/python"
    local flash_can_script="$KLIPPER_DIR/lib/canboot/flash_can.py"

    require_path "$python_bin" "Klippy Python interpreter"
    require_path "$flash_can_script" "Klipper flash_can helper"
    require_path "$firmware_path" "Firmware image"

    log "Flashing $firmware_path to $katapult_dev"
    run_sudo "$python_bin" "$flash_can_script" -f "$firmware_path" -d "$katapult_dev"
}

run_dfu_flash() {
    local firmware_path="$1"
    local output=""
    local status=0

    require_path "$firmware_path" "DFU firmware image"
    require_command dfu-util

    log "Flashing $firmware_path via dfu-util"
    set +e
    output=$(run_sudo dfu-util -R -a 0 -s 0x08000000:leave -D "$firmware_path" 2>&1)
    status=$?
    set -e

    [[ -n "$output" ]] && printf '%s\n' "$output"

    if (( status != 0 )) && ! grep -q "File downloaded successfully" <<<"$output"; then
        die "dfu-util flashing failed"
    fi

    if (( status != 0 )); then
        log "dfu-util reported a known post-download status error, continuing because the file was downloaded successfully"
    fi
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --model)
                [[ $# -ge 2 ]] || die "--model requires a value"
                MODEL="$2"
                shift 2
                ;;
            --dfu)
                FLASH_METHOD="dfu"
                shift
                ;;
            --katapult)
                FLASH_METHOD="katapult"
                shift
                ;;
            --timeout)
                [[ $# -ge 2 ]] || die "--timeout requires a value"
                WAIT_TIMEOUT="$2"
                shift 2
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                die "Unknown argument: $1"
                ;;
        esac
    done
}

main() {
    local carto_dev
    local detected_model
    local firmware_path
    local dfu_firmware_path
    local katapult_dev
    local reconnected_carto

    parse_args "$@"
    case "$FLASH_METHOD" in
        katapult|dfu) ;;
        *) die "Unsupported flash method: $FLASH_METHOD" ;;
    esac

    if [[ "$FLASH_METHOD" == "dfu" ]]; then
        [[ -n "$MODEL" ]] || die "DFU mode requires --model v3 or --model v4 because the probe is already in DFU mode"
    fi

    bootstrap_environment

    if [[ "$FLASH_METHOD" == "dfu" ]]; then
        log "Waiting for initial DFU device"
        wait_for_dfu_device "$WAIT_TIMEOUT"
    fi

    if [[ "$FLASH_METHOD" == "katapult" ]]; then
        log "Waiting for initial Cartographer serial node"
        carto_dev=$(wait_for_cartographer_device "$WAIT_TIMEOUT")
        log "Detected Cartographer serial device: $carto_dev"

        if [[ -z "$MODEL" ]]; then
            detected_model=$(infer_model_from_serial "$carto_dev")
            MODEL="$detected_model"
            log "Auto-detected Cartographer model from serial id: $MODEL"
        fi
    fi

    if [[ "$FLASH_METHOD" == "katapult" ]]; then
        firmware_path=$(firmware_path_for_model "$MODEL")
        log "Using Katapult firmware for model $MODEL"

        run_enter_bootloader "$carto_dev"

        log "Waiting for application serial node to disappear"
        wait_for_absent "$carto_dev" "$WAIT_TIMEOUT"

        log "Waiting for katapult serial node"
        katapult_dev=$(wait_for_match "$BOOTLOADER_GLOB" "$WAIT_TIMEOUT")
        log "Detected katapult device: $katapult_dev"

        run_flash "$firmware_path" "$katapult_dev"

        log "Waiting for katapult device to disconnect after flashing"
        wait_for_absent "$katapult_dev" "$WAIT_TIMEOUT"
    else
        dfu_firmware_path=$(dfu_firmware_path_for_model "$MODEL")
        log "Using DFU firmware for model $MODEL"
        run_dfu_flash "$dfu_firmware_path"
    fi

    log "Waiting for Cartographer serial node to return"
    reconnected_carto=$(wait_for_cartographer_device "$WAIT_TIMEOUT")

    log "Cartographer reconnected as: $reconnected_carto"
    send_usage_report "$reconnected_carto" "$MODEL"
    log "Flash flow completed successfully"
}

main "$@"
