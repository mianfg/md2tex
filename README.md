# Traductor Markdown a LaTeX

Como práctica de Lex he realizado el siguiente traductor.

## Introducción

**Markdown** es uno de los lenguajes de marcado más populares y útiles en el mundo de la informática, pues permite tomar apuntes de forma estilizada muy rápidamente.

Por otra parte, **LaTeX** es otro sistema de composición de textos, mucho más complejo y más lento de usar. Insertar cosas tan fundamentales como negritas, énfasis, listas, etc. puede resultar tedioso en algunas ocasiones.

**`md2tex`** es la solución para cuando queremos escribir rápidamente texto estilizado en LaTeX, pues convierte texto en Markdown a texto en LaTeX.

## Características del traductor

**`md2tex`** ofrece las siguientes funcionalidades:

* **Traducción.** Es capaz de traducir texto en Markdown de acuerdo a la especificación GSM (ver [_GitHub-flavored Markdown_](#) más adelante) a texto en LaTeX. Soporta las siguientes categorías de Markdown (y una extra :wink:):
  * **HTML.** El traductor dejará los comandos HTML intactos.
  * **Cabeceras (h1-h6).** Incluyendo cabeceras _setext_.
  * **Línea larga.**
  * **Imágenes.** Inserta imágenes, así como su pie de foto.
  * **Tablas.** Inserta tablas, soportando las siguientes características:
    * **Alineación.** Insertando `:` a la izquierda o derecha de los separadores de tablas se puede especificar la alineación de cada columna (de acuerdo a lo especificado en GFM).
    * **Ajuste dinámico.** En caso de que el número de columnas de cada fila sea diferente, `md2tex` rellenará la fila con columnas vacías hasta llegar al número de columnas máximo de la tabla, para evitar errores de renderización en LaTeX.
  * **Listas _itemize_.**
  * **Listas _enumerate_.** Soportando, además, las siguientes características:
    * **Comienzo inteligente.** En caso de que la lista numerada comience en 1, no se insertarán directivas adicionales en LaTeX. Si comienza en un número mayor que 1, se insertará una directiva adicional en LaTeX indicando el comienzo de la lista en ese número.
    * **Corrección de desajustes.** El traductor es capaz de comprender el orden de las listas, incluyendo directivas extra en `\item` para los elementos que no sigan dicho orden.
  * **Citas (_blockquotes_).**
  * **Indentación.**
  * **Bloques de código.** Soportando, además, el _syntax highlighting_ (el lenguaje especificado para el bloque en Markdown será insertado en la traducción).
  * **Estilización** con negritas, énfasis, ambos, tachado y código _inline_.
  * **Enlaces.** Guardando el texto y la URL en la traducción.
* **Customización de comandos LaTeX.** Debido a que, en la mayoría de las ocasiones, el usuario tiene una serie de comandos que usa por su cuenta, `md2tex` hace uso de un fichero de cabecera de C, llamado `latexcommands.h`, modificable por el usuario. El fichero está exhaustivamente especificado para poder sustituir los comandos predeterminados por los comandos que el usuario desee.

## Ficheros

| Nombre de fichero | Descripción |
| --- | --- |
| `defines.h` | `#define` necesarios para el _lexer_, hacen el código más claro y estético |
| `latexcommands.h` | Permite la customización de los comandos LaTeX (ver [_Características del traductor_](#)) |
| `lex.yy.c` | Es el fichero generado al hacer `lex md2tex.l`, lo inserto aquí en caso de que este comando no funcione correctamente |
| `md2tex.c` | Contiene el `main`, llama a `m2tex.l` (traducido a C) y genera archivos para cada fase de la traducción |
| `md2tex.l` | El fichero de `lex`, es el que contiene el código relativo a la traducción de cada fase |

## Sobre la traducción

```mermaid

```

## Consideraciones importantes

### GitHub-flavored Markdown



### Limitaciones técnicas



### Posibles mejoras



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