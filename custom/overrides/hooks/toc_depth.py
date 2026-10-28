"""Limit TOC depth, with optional per-section overrides keyed by heading ID."""


def _prune_toc(items, max_depth, section_depths):
    for item in items:
        depth = int(section_depths.get(item.id, max_depth))
        item.children = [c for c in item.children if c.level <= depth]
        _prune_toc(item.children, depth, section_depths)


def on_page_context(context, page, **kwargs):
    max_depth = int(page.meta.get("toc_depth", 2))
    section_depths = page.meta.get("toc_section_depths", {})
    _prune_toc(page.toc, max_depth, section_depths)
