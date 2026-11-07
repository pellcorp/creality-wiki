"""Fill a meta description from the first paragraph when a page has none."""
import html
import re

MAX_LEN = 155
SKIP_PREFIXES = ("#", "!!!", "???", "<", "|", "-", "*", "+", ">", "!", "{", "[^", ":::", "```", "~~~")


def _clean(text):
    text = re.sub(r"\[([^\]]+)\]\([^)]*\)", r"\1", text)
    text = re.sub(r"\{[^}]*\}", "", text)
    text = re.sub(r"[`*_]", "", text)
    return re.sub(r"\s+", " ", html.unescape(text)).strip()


def _first_paragraph(markdown):
    lines = []
    in_fence = False
    for line in markdown.splitlines():
        stripped = line.strip()
        if stripped.startswith(("```", "~~~")):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        if not stripped:
            if lines:
                break
            continue
        if line.startswith(("    ", "\t")) or re.match(r"\d+\.\s", stripped):
            if lines:
                break
            continue
        if stripped.startswith(SKIP_PREFIXES):
            if lines:
                break
            continue
        lines.append(stripped)
    return _clean(" ".join(lines))


def _truncate(text):
    if len(text) <= MAX_LEN:
        return text
    cut = text[:MAX_LEN].rsplit(" ", 1)[0].rstrip(",;:")
    return cut + "..."


def on_page_markdown(markdown, page, config, files):
    if page.meta.get("description"):
        return
    description = _truncate(_first_paragraph(markdown))
    page.meta["description"] = description or config.get("site_description", "")
