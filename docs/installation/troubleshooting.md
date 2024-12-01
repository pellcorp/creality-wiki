---
title: Built-in blog plugin
icon: material/help
---

# Markdown Example
Well, ma, we talked about this, **we're not gonna go to the lake**, the car's wrecked. George. George. This is *more serious* than I thought. Apparently your mother is amorously infatuated with you instead of your father. Yeah, who are you? __**Check out that**__ four by four.

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