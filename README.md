# Traductor Markdown a LaTeX

Como práctica de Lex he realizado el siguiente traductor.

## Introducción

## GitHub-flavored Markdown


Práctica Lex para Modelos de Computación (DGIIM UGR)



### Aspectos en los que el traductor difiere de la GFM

1. (Ejemplo 37) El espacio en blanco es ignorado al parsear contenido _inline_ en cabeceras (`h1` a `h6`).

| Aspecto | Output GFM | Output traductor |
| --- | --- | --- |
| **Ejemplo 37** | Los espacios en blanco deben ser ignorados al parsear contenido _inline_ en cabeceras | El traductor guarda estos espacios en blanco. Esto es incluso más útil si queremos insertar espacios intencionadamente.
| `#·······foo·····` | `<h1>foo</h1>` | `<h1>······foo·····</h1>` |
| **Ejemplo 49** | Una etiqueta de cabecera (de una a seis `#` individual en una línea) debe de interpretarse como una cabecera vacía. | La única cabecera vacía será del tipo `#·`, si se coloca un único `#` (de uno a seis de ellos) en una línea se dejará tal cual. Este reemplazamiento casi nunca se usa en Markdown (muchos editores no tienen incorporada esta regla). |
| `#` | `<h1></h1>` | `#` |

ej 41, 42, 43, 45, 46

49
En caso de que sea un # solo, no lo parsea como h1
(para qué jaja)

bloques HTML ignorados