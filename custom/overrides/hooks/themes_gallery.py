import re
import urllib.request

THEMES_URL = "https://raw.githubusercontent.com/pellcorp/simple-af-themes/main"
PLACEHOLDER = "<!-- simple-af-themes -->"


# replaces the placeholder with the themes from the simple-af-themes readme, which is generated from the theme zips
def on_page_markdown(markdown, page, **kwargs):
    if PLACEHOLDER not in markdown:
        return markdown

    try:
        with urllib.request.urlopen(f"{THEMES_URL}/README.md", timeout=30) as response:
            readme = response.read().decode("utf-8")
    except Exception:
        return markdown.replace(PLACEHOLDER, "See [Simple AF Themes](https://github.com/pellcorp/simple-af-themes)")

    start = readme.find("\n## ")
    themes = readme[start + 1:] if start >= 0 else ""
    themes = re.sub(r"^## ", "### ", themes, flags=re.M)
    themes = themes.replace("](screenshots/", f"]({THEMES_URL}/screenshots/")
    return markdown.replace(PLACEHOLDER, themes)
