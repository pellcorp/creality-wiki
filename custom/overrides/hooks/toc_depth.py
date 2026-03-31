from mkdocs.structure.toc import AnchorLink


def _prune_toc(items, max_depth):
    for item in items:
        item.children = [c for c in item.children if c.level <= max_depth]
        _prune_toc(item.children, max_depth)


def on_page_context(context, page, **kwargs):
    max_depth = int(page.meta.get("toc_depth", 2))
    if max_depth < 3:
        _prune_toc(page.toc, max_depth)
