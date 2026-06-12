from pathlib import Path
import shutil


def on_post_build(config, **kwargs):
    repo_root = Path(config.config_file_path).resolve().parent
    source = repo_root / "scripts" / "cartographer_flash.sh"
    target = repo_root / config.site_dir / "scripts" / "cartographer_flash.sh"

    if not source.exists():
        raise FileNotFoundError(f"Expected script to publish was not found: {source}")

    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, target)
