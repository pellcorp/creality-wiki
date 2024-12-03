---
hide:
  - toc
  - footer
---


<h1 id="homepage">The simplest things are often the truest.</h1>
Well, ma, we talked about this, **we're not gonna go to the lake**, the car's wrecked. George. George. This is *more serious* than I thought. Apparently your mother is amorously infatuated with you instead of your father. Yeah, who are you? __**Check out that**__ four by four.

## Example of a H2 heading <small>Small variable</small>
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

### Example of a H3 heading <small>Small variable</small>
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?

#### Example of a H4 heading <small>Small variable</small>
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

##### Example of a H5 heading <small>Small variable</small>
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?

!!! bug

    This is an example of a Admonition.

### `parse()`

Returns an object containing the following properties:

* `title`: article title;
* `content`: HTML string of processed article content;
* `textContent`: text content of the article, with all the HTML tags removed;
* `length`: length of an article, in characters;
* `excerpt`: article description, or short excerpt from the content;
* `byline`: author metadata;
* `dir`: content direction;
* `siteName`: name of the site;
* `lang`: content language;
* `publishedTime`: published time;

## The appropriate question

Hi, Marty. Stop it. Is she pretty? Alright, good-bye Einy. Oh, watch that re-entry, it's a little bumpy. Get your meat hooks off of me.

>George, buddy. remember that girl I introduced you to, Lorraine. What are you writing? You have this thing hooked up to the car? I'm sure that in 1985, plutonium is available at every corner drug store, but in 1955, it's a little hard to come by.

[https://deloreanipsum.com/](https://deloreanipsum.com/)

___

## Elements

### Lists

#### Unordered List

- Well, bring her along. This concerns her too.
- Mom, is that you?
- Wait a minute, what are you doing, Doc?
- And he could sleep in my room.

#### Ordered List

1. Well, bring her along. This concerns her too.
2. Mom, is that you?
3. Wait a minute, what are you doing, Doc?
4. And he could sleep in my room.

#### Todo Lists

- [x] Eat
- [x] Sleep
- [ ] Work
- [ ] Repeat

### Tables

| Item  | Amount | Price  |
| ----- | -----: | -----: |
| Bread | 1      | 2.00 $ |
| Milk  | 2      | 3.00 $ |
| Sugar | 1      | 1.00 $ |

### Code 

```php
<?php

function http_path()
{
    $host = (!empty($_SERVER['HTTPS']) ? 'https' : 'http') . '://' . $_SERVER['HTTP_HOST'];
    return env('APP_URL', $host);
}

```