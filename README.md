<p align="center">
    <a href="https://mianfg.me"><img src="./resources/logo.png" width="300px"></a>
</p>

<h1 align="center"><p align="center">md2tex</h1></h1>
<p align="center" id="badges">
    <a href="https://github.com/mianfg/md2tex/blob/master/LICENSE"><img src="https://img.shields.io/github/license/mianfg/md2tex" alt="License"></a> <a href="#"><img src="https://img.shields.io/github/languages/code-size/mianfg/md2tex" alt="Code size"></a> <a href="https://github.com/mianfg/md2tex/commits"><img src="https://img.shields.io/github/last-commit/mianfg/md2tex" alt="Last commit"></a> <a href="https://md2tex.mianfg.me"><img src="https://img.shields.io/badge/-live%20app-orange" alt="Live app"></a>
</p>

> Created by **Miguel Ángel Fernández Gutiérrez** (<https://mianfg.me/>)

**Markdown** is one of the most popular and useful markup languages in computer science, as it allows to write stylized notes fastly and comfortably.

On the other hand, **LaTeX** is another text composition system, way more complex and slow to use. Inserting things as fundamental as bold, italics or lists can be tedious in some occasions.

**`md2tex`** is a solution when we want to write stylized text in LaTeX fastly, as it converts Markdown text to LaTeX.

## Getting started

### Prerequisites

This program only requires a C compiler. In order to automatically construct all the necessary dependencies, you can use the `make` tool

### Execution

Use the provided `makefile`, by doing:

~~~
$> make
~~~

You will get the compiled file `md2tex`, that you can execute on the test Markdown file `example.md`:

~~~
$> ./md2tex example.md
~~~

Check and compare the files `example.md` and the recently generated `example_md2tex.tex`.

You can check out the translation phases by doing:

~~~
$> ./md2tex example.md --preserve
~~~

## Translator specs

**`md2tex`** offers the following functionalities:

* **Translation.** It is able to translate text in Markdown according to the GSM specification (see [_GitHub-flavored Markdown_](#github-flavored-markdown) down below) to text in LaTeX. It supports the following Markdown categories (and an extra one :wink:):
  * **HTML** (`HTML`). The translator will leave HTML text as-is.
  * **Headers (h1-h6)** (`HEADER`). Including _setext_ headers.
  * **Horizontal line** (`LINE`).
  * **Images** (`IMAGE`). Inserts images and image footers.
  * **Tables** (`TABLE`). Inserts tables, with the following features:
    * **Alignment.** Inserting `:` to the left or right of the table separators the alignment of each column can be specified (as stated in GFM).
    * **Dynamic adjusting.** In case the number of columns of each row is different, `md2tex` will fill the row with empty columns, until it reaches the maximum number of columns of the table, in order to avoid rendering errors in LaTeX.
  * **_Itemize_ lists** (`LIST`).
  * **_Enumerate_ lists** (`LIST`). Allowing the following additional features:
    * **Smart start.** In case the enumerated lists starts in 1, no additional LaTeX directives will be included. If it starts with a number greater than 1, an additional LaTeX directive will be added indicating that the list will start with that number.
    * **Automatic disarrangement fixing.** The translator is able to understand the list ordering, including extra directives in `\item` only for the elements that do not follow the list order.
  * **Blockquotes** (`BLOCKQUOTE`).
  * **Indentation** (`INDENT`).
  * **Code blocks** (`CODEBLOCK`). Supporting syntax highlighting (the language specified for the Markdown block will be inserted upon translation).
  * **Styling** (`STYLE`) with bold, italics, both, strikethrough and inline code.
  * **Links** (`LINK`). Saving text and URL in translation.
  * ***Escaping.*** Allows the insertion of an inverted bar `\` before characters that can lead to unwanted behaviour.
  * **_Verbatim_** (`VERBATIM`). The code inserted between `$$` will be translated as-is, deleting the surrounding `$$`. This is useful, for example, if we want to introduce direct LaTeX commands in Markdown.
* **LaTeX commands customization.** As most users have a personalized set of commands used for the elements specified above, `md2tex` uses a C header file, called `latexcommands.h`, that is modifiable by the user. The file is exhaustively docummented to ease the substitution of the default commands by the ones the user wants.

### About translation

Because of dependencies between different Markdown commands, and the nesting possibility, the translation is executed using four phases:

1. **Escaping I.** Substitutes the escaped characters to safe strings that cannot be interpreted as commands.
2. **Blocks.** Substitutes the main blocks.
3. **Styling.** Substitutes the styling commands.
4. **Escaping II.** Substitutes the escaped strings with the original strings.

Because of the way that `lex` parses characters, some commands use the _parse with `ECHO`_ strategy (in other words, read the sequence of characters and do nothing). As `lex` executes the rule upon the longest string, other commands inside the parsed string will be ignored. We can use this as an advantage, but it also imposes [some limitations](#technical-limitations-and-possible-improvements).

Following, a graph that explains which commands are parsed in each translation phase. Consider the tangs mentioned above, and the following strategies:

* **ignore:** do not parse.
* **ECHO:** parse and `ECHO`.
* **action:** the text is modified in some way.

Each arrow symbolizes _next phase_, starting with the first phase.

![phasegraph](./resources/phasegraph.png)

### Important considerations

#### GitHub-flavored Markdown

As there is no Markdown standard, this translator is based upon the [GitHub-flavored Markdown](https://github.github.com/gfm/) spec. It consists on more than 600 rules and examples.

This translator is able to translate most of these rules, except some of them for two reasons:

* They are "unuseful" rules (most parsers do not implement them).
* They are rules that cannot be interpreted by regular expressions (and thus by regular languages).

#### Technical limitations and possible improvements

Because of some limitations of `lex` (and because the implementation is very difficult), the following features do not work completely on this translator:

* Styles nesting: if we want to place italics inside a portion of a bold text, for example. It can be avoided concatenating the available styles.
* Multiple list levels: the translator is only able to interpret lists in one level of depth.
* Styles in image and link texts: can be implemented with one extra translation phase. I deemed it unnecesary.

These features can be implemented in future versions of `md2tex`.

## Files

| Filename | Description |
| --- | --- |
| [`defines.h`](./defines.h) | Necessary `#define` for the lexer, they make the code more legible |
| [`example.md`](./example.md) | Example that uses almost all Markdown tags |
| [`example_md2tex.tex`](./example_md2tex.tex) | Output of executing `md2tex` to the previous example |
| [`latexcommands.h`](./latexcommands.h) | Allows customization of LaTeX commands (se [_Translator specs_](#translator-specs)) |
| [`lex.yy.c`](./lex.yy.c) | It is the generated file by doing `lex md2tex.l`, I insert it here in case the `lex` command does not work properly |
| [`makefile`](./makefile) | Eases compilation |
| [`md2tex_main.c`](./md2tex_main.c) | Contains the `main` function, calls `m2tex.l` (translated to C) and generates files for each phase of translation |
| [`md2tex.l`](./md2tex.l) | `lex` file, it contains the code concerning each phase of translation |
