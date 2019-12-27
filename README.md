# Traductor Markdown a LaTeX

Como práctica de Lex he realizado el siguiente traductor.

## Introducción

## GitHub-flavored Markdown


Práctica Lex para Modelos de Computación (DGIIM UGR)



### Aspectos en los que el traductor difiere de la GFM

1. (Ejemplo 37) El espacio en blanco es ignorado al parsear contenido _inline_ en cabeceras (`h1` a `h6`).

| | Fuente | Parse |
| --- | --- | --- |
| GFM | `#·······foo·····` | `<h1>foo</h1>` |
| TRA | `#·······foo·····` | `<h1>······foo·····</h1>` |

ej 41, 42, 43, 45, 46

49
En caso de que sea un # solo, no lo parsea como h1
(para qué jaja)

bloques HTML ignorados