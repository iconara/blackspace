# Blackspace

Atom's default whitespace handling leaves a lot of whitespace around where it shouldn't be. This package fixes one of the more problematic areas.

## Example

Consider this scenario (`·` is a space, `¬` is a newline and `|` is the insertion point):

```
def foobar
··|
```

What would you want to happen if you pressed return? This is what you get by default in Atom:

```
def foobar
··¬
··|
```

You get a line with only whitespace. Most tools that care about whitespace, like `git`, `diff`, and most editors that shows trailing whitespace will complain about this.

What this package does is that it makes sure that you instead end up with this:

```
def foobar
¬
··|
```

I.e. a blank line without whitespace. If you press return again a few times you will get this:

```
def foobar
¬
¬
¬
··|
```

## But doesn't Atom's built-in whitespace package already solve this?

No. It strips whitespace in the whole file, regardless of whether you touched the code or not. If you edit a single line, save and try to commit the change you might have caused lots of unrelated changes because the file had trailing whitespace. When you collaborate with other people it is extremely frustrating when everyone's editors automatically strip whitespace, adds newlines to the end of times, removes newlines from the end of files, automatically reformats code, etc. The commit history gets very, very messy.

## Copyright

2014 Theo Hultberg / Iconara

Licensed under the BSD license, see `LICENSE.md`.