---
title: Changlog
---

Text here

## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~

!!! type "optional explicit title within double quotes"
    Any number of other indented markdown elements.

    This is the second paragraph.


>>> import markdown
>>> src = """This is ++added content++ and this is ~~deleted content~~""" 
>>> html = markdown.markdown(src, ['del_ins'])
>>> print(html)
<p>This is <ins>added content</ins> and this is <del>deleted content</del>
</p>