---
title: Markdown examples
hide:
  - footer
---

# Markdown example file

To change the announcement bar content at the top you need to change `material/overrides/main.html`

change the following:

``` html hl_lines="9 10 11"
{#-
  This file was automatically generated - do not edit
-#}
{% extends "base.html" %}
{% block extrahead %}
  <link rel="stylesheet" href="{{ 'assets/stylesheets/custom.css' | url }}">
{% endblock %}
{% block announce %}
  <div class="announce_text">
    Some info and updates here!
  </div>
{% endblock %}
{% block scripts %}
  {{ super() }}
  <script src="{{ 'assets/javascripts/custom.js' | url }}"></script>
{% endblock %}

```

Change `Some info and updates here!`.

Every time this announcement has changed the bar will reapear if people have clicked it away.<br>
_(it will stay hidden until this file has been changed)_

# H1
## H2
### H3
#### H4
##### H5
###### H6

<hr>

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~

This is a <sub>subscript</sub> text

This is a <sup>superscript</sup> text

This is an <ins>underlined</ins> text

- H~2~O
- A^T^A

++ctrl+alt+del++

- [x] No installation needed in [Docker image]
- [x] No installation needed in [GitHub Actions] (Ubuntu)
- [ ] Example of an unchecked box

### Highlighted text
Text can be {--deleted--} and replacement text {++added++}. This can also be
combined into {~~one~>a single~~} operation. {==Highlighting==} is also
possible {>>and comments can be added inline<<}.

{==

Formatting can also be applied to blocks by putting the opening and closing
tags on separate lines and adding new lines between the tags and the content.

==}

<!-- Example of a comment -->


#### Ignore formatting
Ignore markdown formatting:
Let's rename \*our-new-project\* to \*our-old-project\*.

## Quote's
Text that is not a quote

> Text that is a quote

> If we pull together and commit ourselves, then we can push through anything.

— Mona the Octocat

## Admonitions

### Basic
!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

### Changing the title
!!! note "Phasellus posuere in sem ut cursus"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

### Removing the title
!!! note ""

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

### Collapsible blocks
??? note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

??? tip

    Different types too! by replacing the `note` in the following:
    ```
    ??? note

        I'm a collapsable block
    ```

## Supported types
`note`
!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`abstract`
!!! abstract

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`info`
!!! info

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`tip`
!!! tip

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`success`
!!! success

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`question`
!!! question

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`warning`
!!! warning

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`failure`
!!! failure

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`danger`
!!! danger

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`bug`
!!! bug

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`example`
!!! example

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
`quote`
!!! quote

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

The above are default admonitions, custom ones can also be made.
For further documentation visit [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/reference/admonitions/)

## Codeblocks


### Adding annotations
``` yaml
theme:
  features:
    - content.code.annotate # (1)
```

1.  :man_raising_hand: I'm a code annotation! I can contain `code`, __formatted
    text__, images, ... basically anything that can be written in Markdown.

### Adding a title
``` py title="bubble_sort.py"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```

### Adding line numbers
``` py linenums="1"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```

### Highlight specefic lines
``` py hl_lines="2 3"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```


``` { py title="namefile.py" linenums="1" .select }
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```
=== ":octicons-file-code-16: `cartographer.conf`"

    ``` linenums="1" hl_lines="4 5"
    [update_manager Cartographer]
    type: git_repo
    path: usrdatacartographer-klipper
    channel: stable
    primary_branch: master
    origin: https://github.com/Cartographer3D/cartographer-klipper.git
    install_script: install.sh
    is_system_service: False
    managed_services: klipper
    info_tags:
        desc=Cartographer Probe
    ```

### Highlighting inline code blocks
The `#!python range()` function is used to generate a sequence of numbers.

### Content tabs
=== "C"

    ``` c
    #include <stdio.h>

    int main(void) {
      printf("Hello world!\n");
      return 0;
    }
    ```

=== "C++"

    ``` c++
    #include <iostream>

    int main(void) {
      std::cout << "Hello world!" << std::endl;
      return 0;
    }
    ```

## Data tables

### Example
| Method      | Description                          |
| ----------- | ------------------------------------ |
| `GET`       | :material-check:     Fetch resource  |
| `PUT`       | :material-check-all: Update resource |
| `DELETE`    | :material-close:     Delete resource |

### Center aligned
| Method      | Description                          |
| :---------: | :----------------------------------: |
| `GET`       | :material-check:     Fetch resource  |
| `PUT`       | :material-check-all: Update resource |
| `DELETE`    | :material-close:     Delete resource |


### More tabs
|File                   |Section            |Key            |Value                  |
|-----------------------|-------------------|---------------|-----------------------|
|`printer.cfg`          |stepper_y          |position_max   |226 (K1) or 306 (K1M)  |
|`cartotouch.cfg`       |scanner            |x_offset       |-16.0                  |
|                       |                   |y_offset       |0.0                    |
|`cartographer-k1.cfg`  |bed_mesh           |mesh_min       |10,10                  |
|                       |                   |mesh_max       |210,215                |
|                       |screws_tilt_adjust |screw1         |42,20                  |
|                       |                   |screw2         |211,20                 |
|                       |                   |screw3         |211,190                |
|                       |                   |screw4         |42,190                 |
|`cartographer-k1m.cfg` |bed_mesh|mesh_min  |10,10          |                       |
|`cartographer-k1m.cfg` |                   |mesh_max       |290,280                |
|                       |screws_tilt_adjust |screw1         |35,23                  |
|                       |                   |screw2         |294,23                 |
|                       |                   |screw3         |264,272                |
|                       |                   |screw4         |64,272                 |


## Footnotes
Footnotes are a great way to add supplemental or additional information to a specific word, phrase or sentence without interrupting the flow of a document. Material for MkDocs provides the ability to define, reference and render footnotes.

Lorem ipsum[^1] dolor sit amet, consectetur adipiscing elit.[^2] (example of these at the bottom)

## Grids
<div class="grid cards" markdown>

-   :material-clock-fast:{ .lg .middle } __Set up in 5 minutes__

    ---

    Install [`mkdocs-material`](#) with [`pip`](#) and get up
    and running in minutes

    [:octicons-arrow-right-24: Getting started](#)

-   :fontawesome-brands-markdown:{ .lg .middle } __It's just Markdown__

    ---

    Focus on your content and generate a responsive and searchable static site

    [:octicons-arrow-right-24: Reference](#)

-   :material-format-font:{ .lg .middle } __Made to measure__

    ---

    Change the colors, fonts, language, icons, logo and more with a few lines

    [:octicons-arrow-right-24: Customization](#)

-   :material-scale-balance:{ .lg .middle } __Open Source, MIT__

    ---

    Material for MkDocs is licensed under MIT and available on [GitHub]

    [:octicons-arrow-right-24: License](#)

</div>

## Lists

### Unordered list
- Nulla et rhoncus turpis. Mauris ultricies elementum leo. Duis efficitur
  accumsan nibh eu mattis. Vivamus tempus velit eros, porttitor placerat nibh
  lacinia sed. Aenean in finibus diam.

    * Duis mollis est eget nibh volutpat, fermentum aliquet dui mollis.
    * Nam vulputate tincidunt fringilla.
    * Nullam dignissim ultrices urna non auctor.

### Ordered list
1.  Vivamus id mi enim. Integer id turpis sapien. Ut condimentum lobortis
    sagittis. Aliquam purus tellus, faucibus eget urna at, iaculis venenatis
    nulla. Vivamus a pharetra leo.

    1.  Vivamus venenatis porttitor tortor sit amet rutrum. Pellentesque aliquet
        quam enim, eu volutpat urna rutrum a. Nam vehicula nunc mauris, a
        ultricies libero efficitur sed.

    2.  Morbi eget dapibus felis. Vivamus venenatis porttitor tortor sit amet
        rutrum. Pellentesque aliquet quam enim, eu volutpat urna rutrum a.

        1.  Mauris dictum mi lacus
        2.  Ut sit amet placerat ante
        3.  Suspendisse ac eros arcu

### Defenition lists
`Lorem ipsum dolor sit amet`

:   Sed sagittis eleifend rutrum. Donec vitae suscipit est. Nullam tempus
    tellus non sem sollicitudin, quis rutrum leo facilisis.

`Cras arcu libero`

:   Aliquam metus eros, pretium sed nulla venenatis, faucibus auctor ex. Proin
    ut eros sed sapien ullamcorper consequat. Nunc ligula ante.

:    Duis mollis est eget nibh volutpat, fermentum aliquet dui mollis.
    Nam vulputate tincidunt fringilla.
    Nullam dignissim ultrices urna non auctor.

### Task lists
- [x] Lorem ipsum dolor sit amet, consectetur adipiscing elit
- [ ] Vestibulum convallis sit amet nisi a tincidunt
    * [x] In hac habitasse platea dictumst
    * [x] In scelerisque nibh non dolor mollis congue sed et metus
    * [ ] Praesent sed risus massa
- [ ] Aenean pretium efficitur erat, donec pharetra, ligula non scelerisque

### Grouped list
<div class="grid" markdown>

=== "Unordered list"

    * Sed sagittis eleifend rutrum
    * Donec vitae suscipit est
    * Nulla tempor lobortis orci

=== "Ordered list"

    1. Sed sagittis eleifend rutrum
    2. Donec vitae suscipit est
    3. Nulla tempor lobortis orci

``` title="Content tabs"
=== "Unordered list"

    * Sed sagittis eleifend rutrum
    * Donec vitae suscipit est
    * Nulla tempor lobortis orci

=== "Ordered list"

    1. Sed sagittis eleifend rutrum
    2. Donec vitae suscipit est
    3. Nulla tempor lobortis orci
```
</div>


## Custom markdown

Custom made for SimpleAF wiki a step by step ordered list markdown parser

--steps--

1.  

    Vivamus id mi enim. Integer id turpis sapien. Ut condimentum lobortis
    sagittis. Aliquam purus tellus, faucibus eget urna at, iaculis venenatis
    nulla. Vivamus a pharetra leo.

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.

2.  

    Vivamus venenatis porttitor tortor sit amet rutrum. Pellentesque aliquet
    quam enim, eu volutpat urna rutrum a. Nam vehicula nunc mauris, a

    ultricies libero efficitur sed. Aliquam purus tellus, faucibus eget
    urna at, iaculis venenatis nulla. Vivamus a pharetra leo.

3.  

    Morbi eget dapibus felis. Vivamus venenatis porttitor tortor sit amet
    rutrum. Pellentesque aliquet quam enim, eu volutpat urna rutrum a.

--!steps--

### Usage:
These can be done in 2 different options,
my prefered option is #1, it's easier to see.
_(take note of the indents ++tab++ and white-lines ++enter++ )_

#### Option 1
```
--steps--

1.  

    Vivamus id mi enim. Integer id turpis sapien. Ut condimentum lobortis
    sagittis. Aliquam purus tellus, faucibus eget urna at, iaculis venenatis
    nulla. Vivamus a pharetra leo.

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.

2.  

    Vivamus venenatis porttitor tortor sit amet rutrum. Pellentesque aliquet
    quam enim, eu volutpat urna rutrum a. Nam vehicula nunc mauris, a

    ultricies libero efficitur sed. Aliquam purus tellus, faucibus eget
    urna at, iaculis venenatis nulla. Vivamus a pharetra leo.

3.  

    Morbi eget dapibus felis. Vivamus venenatis porttitor tortor sit amet
    rutrum. Pellentesque aliquet quam enim, eu volutpat urna rutrum a.

--!steps--
```
#### Option 2
```
--steps--

1.  Vivamus id mi enim. Integer id turpis sapien. Ut condimentum lobortis
    sagittis. Aliquam purus tellus, faucibus eget urna at, iaculis venenatis
    nulla. Vivamus a pharetra leo.

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.

2.  Vivamus venenatis porttitor tortor sit amet rutrum. Pellentesque aliquet
    quam enim, eu volutpat urna rutrum a. Nam vehicula nunc mauris, a

    ultricies libero efficitur sed. Aliquam purus tellus, faucibus eget
    urna at, iaculis venenatis nulla. Vivamus a pharetra leo.

3.  Morbi eget dapibus felis. Vivamus venenatis porttitor tortor sit amet
    rutrum. Pellentesque aliquet quam enim, eu volutpat urna rutrum a.

--!steps--
```




[^1]: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
[^2]: Lorem ipsum dolor sit amet, consectetur adipiscing elit.