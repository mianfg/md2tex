# Manual de Markdown

> Miguel Ángel Fernández Gutiérrez ([@mianfg](https://mianfg.bloomgogo.com))

## Introducción

Markdown es uno de los lenguajes de marcado más importantes, por su sencillez, rapidez y versatilidad. En este manual te explico cómo usar Markdown (y esto es _todo lo que hay_ :wink:).

## Sintaxis de Markdown

La mejor manera de hacerse una idea de la sintaxis de Markdown es simplemente echar un vistazo a un escrito formateado como tal.

~~~
## Título
### Subtítulo
Este es un ejemplo de texto que da entrada a una lista genérica de elementos:

- Elemento 1
- Elemento 2
- Elemento 3

Este es un ejemplo de texto que da entrada a una lista numerada:

1. Elemento 1
2. Elemento 2
3. Elemento 3

Al texto en Markdown puedes añadirle formato como **negrita** o *cursiva* de una manera muy sencilla.
~~~

Como ves, se cumple perfectamente uno de los objetivos para los que Markdown fue diseñado, y es hacer las publicaciones lo más legibles posible.

Otro de los objetivos de Markdown, es que puedas publicar los documentos “como están”. No importa si el resultado final que necesitas es HTML, un PDF o texto en formato enriquecido (RTF); ya que siempre podrás obtener estos formatos a través de un conversor, o a través de aplicaciones compatibles con Markdown.
Índice de sintaxis Markdown

## Índice

En el lenguaje Markdown encontrarás tres tipos de elementos básicos que a su vez engloban el resto de la sintaxis. Considera esto una _cheat sheet_ con la que guiarte.

* [Elementos de bloque](#elementos-de-bloque)
* [Párrafos y saltos de línea](#párrafos-y-saltos-de-línea)
* [Encabezados](#encabezados)
* [Citas](#citas)
* [Listas](#listas)
* [Códigos de bloque](#códigos-de-bloque)
* [Reglas horizontales](#reglas-horizontales)
* [Elementos de línea](#elementos-de-línea)
* [Énfasis](#Énfasis-negritas-y-cursivas)
* [Links o enlaces](#links-o-enlaces)
* [Código](#código)
* [Imágenes](#imágenes)
* [Elementos varios](#elementos-varios)
* [Tablas](#tablas)
* [Links automáticos](#links-automáticos-1)
* [Omitir Markdown](#omitir-markdown)
* [Cositas de GitHub](#cositas-de-github)

## Elementos de bloque

### Párrafos y saltos de línea

Para generar un nuevo párrafo en Markdown simplemente separa el texto mediante una línea en blanco **(pulsando dos veces intro)**.

Al igual que sucede con HTML, **Markdown no soporta dobles líneas en blanco**, así que si intentas generarlas estas se convertirán en una sola al procesarse.

Para realizar un salto de línea y empezar una frase en una línea siguiente dentro del mismo párrafo, tendrás que pulsar dos veces la barra espaciadora antes de pulsar una vez intro.

Por ejemplo si quisieses escribir un poema Haiku quedaría tal que así:

_“Andando con sus patitas mojadas,_  
_el gorrión_  
_por la terraza de madera”_  

Donde cada verso tiene dos espacios en blanco al final.

### Encabezados

Las `#` **almohadillas** son uno de los métodos utilizados en Markdown para crear encabezados. Debes usarlos añadiendo **uno por cada nivel**.

Es decir,

~~~ markdown
# Encabezado 1
## Encabezado 2
### Encabezado 3
#### Encabezado 4
##### Encabezado 5
###### Encabezado 6
~~~

Se corresponde con

# Encabezado 1
## Encabezado 2
### Encabezado 3
#### Encabezado 4
##### Encabezado 5
###### Encabezado 6

También puedes cerrar los encabezados con el mismo número de almohadillas, por ejemplo escribiendo `### Encabezado 3 ###`. Pero la única finalidad de esto es un **motivo estético**.

Existe otra manera de generar encabezados, aunque este método está **limitado a dos niveles**.

Consiste en subrayar los encabezados con el símbolo `=` (para el encabezado 1), o con guiones `-` para el encabezado 2.

Es decir,

~~~ md
Esto sería un encabezado 1
===
Esto sería un encabezado 2
--
~~~

No existe un número concreto de `=` o `-` que necesites escribir para que esto funcione, ¡incluso bastaría con uno!

### Citas

Las citas se generar utilizando el carácter mayor que > al comienzo del bloque de texto.

~~~ md
> Un país, una civilización se puede juzgar por la forma en que trata a sus animales.  — Mahatma Gandhi
~~~

> Un país, una civilización se puede juzgar por la forma en que trata a sus animales.  — Mahatma Gandhi

Si la cita en cuestión se compone de varios párrafos, deberás añadir el mismo símbolo > al comienzo de cada uno de ellos.

~~~ md
> Creo que los animales ven en el hombre un ser igual a ellos que ha perdido de forma extraordinariamente peligrosa el sano intelecto animal.
> Es decir, que ven en él al animal irracional, al animal que ríe, al animal que llora, al animal infeliz. — Friedrich Nietzsche
~~~

> Creo que los animales ven en el hombre un ser igual a ellos que ha perdido de forma extraordinariamente peligrosa el sano intelecto animal.
> Es decir, que ven en él al animal irracional, al animal que ríe, al animal que llora, al animal infeliz. — Friedrich Nietzsche

Recuerda separar los **saltos de línea** con `>`, o `>>` si te encuentras dentro de la cita anidada; para crear párrafos dentro del mismo bloque de cita.

### Listas

A diferencia de lo que ocurre en HTML, generar listas en Markdown es tremendamente sencillo. Puedes encontrarte con dos tipos.

#### Listas desordenadas

Para crear **listas desordenadas** utiliza `*` **asteriscos**, `-` **guiones**, o `+` **símbolos de suma**.

~~~ md
- Elemento de lista 1
- Elemento de lista 2
* Elemento de lista 3
* Elemento de lista 4
+ Elemento de lista 5
+ Elemento de lista 6
~~~

Da igual qué elemento escojas, incluso puedes intercambiarlos. Todos se verán igual al procesarse.

- Elemento de lista 1
- Elemento de lista 2
* Elemento de lista 3
* Elemento de lista 4
+ Elemento de lista 5
+ Elemento de lista 6

#### Listas ordenadas

Para crear listas ordenadas debes utilizar la sintaxis de tipo: _“número.”_ `1.`.

~~~ md
2. Elemento de lista 2
3.  Elemento de lista 3
6. Elemento de lista desordenado
5. Elemento de lista 5
~~~

2. Elemento de lista 2
3.  Elemento de lista 3
6. Elemento de lista desordenado
5. Elemento de lista 5

## Códigos de bloque

Si quieres crear un bloque entero que contenga código. Lo único que tienes que hacer es encerrar dicho párrafo entre dos líneas formadas por tres `~` **virgulillas**.

De esta forma, obtendrás el siguiente resultado:

~~~
Creando códigos de bloque.
Puedes añadir tantas líneas y párrafos como quieras.  
~~~

Colocando a la derecha del `~~~` el nombre del lenguaje a utilizar, se formateará el texto de acuerdo al lenguaje.

### Reglas horizontales

Las `reglas horizontales` se utilizan para separar secciones de una manera visual. Las estás viendo constantemente en este artículo ya que las estoy utilizando para separar los diferentes elementos de sintaxis de Markdown.

Para crearlas, en una línea en blanco deberás incluir tres de los siguientes elementos: asteriscos, guiones, o guiones bajos.

Es decir

~~~ md
***
---
___
~~~

***
---
___

También puedes separarlos mediante un espacio en blanco por pura estética.

~~~ md
* * *
- - -
_ _ _
~~~

## Elementos de línea
### Énfasis (negritas y cursivas)

Markdown utiliza `*` **asteriscos** o `_` **guiones bajos** para enfatizar.

Simplemente tendrás que envolver palabras o textos en éstos símbolos para conseguir cursivas o negritas.

| Markdown | Resultado |
| --- | --- |
| `*cursiva*` | *cursiva* |
| `_cursiva_` | _cursiva_ |
| `**negrita**` | **negrita** |
| `__negrita__` | __negrita__ |

Por supuesto si quieres utilizar los dos tipos de énfasis no tienes más que combinar la sintaxis, envolviendo la palabra entre tres asteriscos o tres guiones bajos.

| Markdown | Resultado |
| --- | --- |
| `***cursiva y negrita***` | ***cursiva y negrita*** |
| `___cursiva y negrita___` | ___cursiva y negrita___ |

### Links o enlaces

Añadir enlaces a una publicación, más que común, hoy en día es algo casi obligatorio. Con Markdown tendrás varias formas de hacerlo.

#### Links o enlaces en línea

Son los enlaces de toda la vida. Como su nombre indica, se encuentran en línea con el texto.

Se crean escribiendo la palabra o texto enlazada entre `[]` **corchetes**, y el link en cuestión entre `()` **paréntesis**.

| Markdown | Resultado |
| --- | --- |
| `[enlace](http://example.com/)` | [enlace](http://example.com/) |

## Código

En según que tipo de publicaciones (sobre todo las de carácter técnico), necesitarás añadir pequeñas secciones donde mostrar código de otro lenguaje, atajos de teclado, o demás contenido que no debería ser tratado como tal.

Para ello tienes disponible dos alternativas.

### Código puro `<code>`

La forma más sencilla de escribir código en Markdown es envolver el texto entre dos **acentos graves** \`. Esto se corresponde con la etiqueta HTML `<code>`.

~~~ md
`Esto es una línea de código`
~~~

Se verá como `Esto es una línea de código`.

Como ves, es muy útil para introducir código dentro de la misma línea o párrafo, algo que no permite el método siguiente.

### Imágenes

Insertar una imagen con Markdown se realiza de una manera prácticamente idéntica a insertar links.

Solo que en este caso, deberás añadir un símbolo de `!` **exclamación** al principio y el enlace no será otro que la ubicación de la imagen.

~~~md
![Texto alternativo](/ruta/a/la/imagen.jpg)
~~~

El texto alternativo es lo que se mostraría si la carga de la imagen fallase.

También podrás añadir un título alternativo entrecomillándolo al final de la ruta. Esto sería el título mostrado al dejar el cursor del ratón sobre la imagen.

~~~
![Texto alternativo](/ruta/a/la/imagen.jpg "Título alternativo")
~~~

## Elementos varios

### Tablas

Añadir una tabla es muy sencillo: simplemente sigue el siguiente formato.

~~~ md
| Nombre | Descripción |
| ------ | ----------- |
| Hoola  | Helouu      |
| Adioss | Byee        |
~~~

| Nombre | Descripción |
| ------ | ----------- |
| Hoola  | Helouu      |
| Adioss | Byee        |

Puedes añadir el número de `-` que quieras (debe haber al menos uno), pero sólo después de la primera fila: si añades más, aparecerá _per se_, y si no lo añades tras la primera fila, no se generará la tabla.

### Omitir Markdown

Si has llegado hasta aquí es probable que te estés preguntando cómo he conseguido escribir ciertos símbolos como `*` asteriscos o `_` guiones bajos, sin que Markdown los interprete para convertirlos en negritas, cursivas…

Esto es muy sencillo, ya que en este lenguaje existe un elemento estrella para especificar que todo lo que escribas a continuación, no se interprete como Markdown.

Se trata de la **barra invertida** `\`.

Escribiéndola justo delante de cualquiera de los elementos que verás a continuación, los mismos no tendrán efecto a la hora de convertirse en negritas, cursivas, links…

| Símbolo | Descripción |
| --- | --- |
| \\ | barra invertida |
| \` | acento invertido |
| \* | asterisco |
| \_ | guión bajo |
| \{\} | llaves |
| \[\] | corchetes |
| \(\) | paréntesis |
| \# | almohadilla |
| \+ | símbolo de suma |
| \- | guión |
| \. | punto |
| \! | exclamación |

## Cositas de GitHub

Los Markdown en GitHub (que deben tener extensión `.md`) tienen una serie de funcionalidades añadidas que podrás encontrar [aquí](https://guides.github.com/features/mastering-markdown/).

> Basado en el texto de <https://markdown.es/>