# Agenda

0. Demo

What are we going to create?

> We are creating utility to unfurl links from webpages
> with ability to extend with custom logic.

1. Init app

https://crystal-lang.org/docs/installation/
https://crystal-lang.org/docs/
https://crystal-lang.org/api/0.25.1/

Tools:

http://crystalshards.xyz/
https://github.com/veelenga/awesome-crystal
https://github.com/crystal-community/icr

2. Code structure

- shards / shard.yml
- .gitignore
- simple hello
- shards


3. Configure guardian:

https://github.com/f/guardian

- rerun app on change (for web apps it's better to use sentry)
- install shards automatically
- run specs on change
- run static code analysis (https://github.com/veelenga/ameba)

4. Ruby diff

- require `./`, `**`
- visibility modifiers (private/protected/public)
- new types (tuple / named tuple)
- arithmetic overflow
- "safe" by default (first vs. first?)
- `&.` is better
- `&&`, `||`
- single method with proper english
- method overloading
- auto keyword arguments
- previous_def / alias
- stdlib
- ...

https://docs.google.com/presentation/d/1XeIRwl1Y9IUAxsFdmUmRjpLl1CrIzRgFo5wdWJrsYTc


5. Design the lib/app

classes:

- Link
- Resolver/Strategy (abstract)
- Config

Usage:

```crystal
link = Unfurl::Link.new(uri)
link.unfurl
```

Configuration:
- allow to specify list of resolvers

Resolver:
- matches?
- resolve

Unfurling:
```pseudocode
FOR EACH resolver:
    IF resolver matches uri THEN
        resolve uri
        IF result IS NIL THEN
            return NOT_FOUND, "message"
        ELSE
            return OK, "url"

WHEN no resolvers found:
    return ERROR, "message"
```

6. Refactor

- alias
- initializer list


Unfurling:

7. Extras
https://github.com/luckyframework/habitat
https://github.com/crystal-community/cossack
https://github.com/waterlink/spec2.cr
https://github.com/waterlink/mocks.cr
