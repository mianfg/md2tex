# Traductor Markdown a LaTeX

Como práctica de Lex he realizado el siguiente traductor.

## Introducción

## GitHub-flavored Markdown


Práctica Lex para Modelos de Computación (DGIIM UGR)



### Aspectos en los que el traductor difiere de la GFM

1. (Ejemplo 37) El espacio en blanco es ignorado al parsear contenido _inline_ en cabeceras (`h1` a `h6`).

El formato de las entradas será del siguiente tipo:

| Aspecto | Output GFM | Output traductor |
| --- | --- | --- |
| Número de ejemplo GFM | Explicación del comportamiento especificado por GFM | Comportamiento de nuestro traductor (en caso de que no haga estrictamente lo especificado en GFM) |
| _Entrada_ | _Salida esperada GFM_ | _Salida traductor_ |

---

| Aspecto | Output GFM | Output traductor |
| --- | --- | --- |
| **Ejemplo 37** | Los espacios en blanco deben ser ignorados al parsear contenido _inline_ en cabeceras | El traductor guarda estos espacios en blanco. Esto es incluso más útil si queremos insertar espacios intencionadamente.
| `#·······foo·····` | `<h1>foo</h1>` | `<h1>······foo·····</h1>` |
| **Ejemplo 49** | Una etiqueta de cabecera (de una a seis `#` individual en una línea) debe de interpretarse como una cabecera vacía. | La única cabecera vacía será del tipo `#·`, si se coloca un único `#` (de uno a seis de ellos) en una línea se dejará tal cual. Este reemplazamiento casi nunca se usa en Markdown (muchos editores incorporan esta regla). |
| `#` | `<h1></h1>` | `#` |

ej 41, 42, 43, 45, 46

49
En caso de que sea un # solo, no lo parsea como h1
(para qué jaja)

bloques HTML ignorados

81
no se hace, es innecesario

94, 95
NO ES REGULAR

96,97,98

101,102,103

104
No lo hace

112
IMPLEMENTAR


116 WTF

121-125 no


131 no

147 revisar e implementar
150-151 CDATA

157
159,160 no


link reference definitions not implemented

Párrafos como en LaTeX


203

369
left-flanking delimiter run
intraword ** no __
399
401

resumir en *** ___ para ambos