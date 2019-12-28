    /* ---- Sección de declaraciones ---- */

    // Fases de traducción

%s phase1
%s phase2
%s phase3
%s phase4

    // Expresiones regulares

verbatim        ^"$$"[."\n"]*"$$"
    // ------ VERIFY
h1              ^" "{0,3}"# ".*$
    // all good
h2              ^" "{0,3}"## ".*$
    // all good
h3              ^" "{0,3}"### ".*$
    // all good
h4              ^" "{0,3}"#### ".*$
    // all good
h5              ^" "{0,3}"##### ".*$
    // all good
h6              ^" "{0,3}"###### ".*$
    // all good
h1setext        ^(.+\n)+" "{0,3}"="+$
    // all good
h2setext        ^(.+\n)+" "{0,3}"-"+$
    // all good

    //line1           ^" "{0,3}"*"" "*"*"" "*"*"" "*[" ""*"]*$
    //line2           ^" "{0,3}"-"" "*"-"" "*"-"" "*[" ""-"]*$
    //line3           ^" "{0,3}"_"" "*"_"" "*"_"" "*[" ""_"]*$

line            (^" "{0,3}"*"" "*"*"" "*"*"" "*[" ""*"]*$|^" "{0,3}"-"" "*"-"" "*"-"" "*[" ""-"]*$|^" "{0,3}"_"" "*"_"" "*"_"" "*[" ""_"]*$)
    // all good
indent          ^" "{4,}.*$
    // ------ VERIFY
tableh          " "*"| "(.*" | ").*" |"" "*"\n"
    // all good
tables          " "*"|"(" "*":"?[" ""\-"]*"-"[" ""\-"]*":"?" "*"|")+" "*"\n"
    // all good
    // opcion2 " "*"|"(" "*":"?"-"+":"?" "*"|")+" "*"\n"
    //"|"(" "?":"?"-"+[" ""-"]*":"?" "?"|")+
table           ^{tableh}{tables}{tableh}*
    // all good
bullist         "foo"
    // ------ DO
numlist         "fooo"
    // ------ DO
blockfirst      " "{0,3}">".*"\n"
    // all good
blocknext       .+\n
    // all good
blockquote      {blockfirst}{blocknext}*
    // all good but VERIFY

    // link
    // image
    // WIP modify strong and others to be like codeinline

link            "\["[^"\[""\]""\n"]+"\]""\("[^"\(""\)""\n"]+"\)"
    // all good  --- TRY LINK FIRST, BOLD THEN (SUBSTITUTE BOLD ETC IN [] OF LINK)

html            ("<".+">".*(.*\n)*"</".+">"|"<!".*(.*\n)*">")
    // all good
codeblockind    ^("    ".+\n)+$
    // ------ VERIFY
codeblock1      ^"`"{3,}(.*\n)([^"`"{1,3}].*\n)*" "{0,3}"`"{3,}" "*$
codeblock2      ^"~"{3,}(.*\n)([^"~"{1,3}].*\n)*" "{0,3}"~"{3,}" "*$
    //codeblock       ((^"`"{3,}(.*\n)*" "{0,3}"`"{3,}$)|(^"~"{3,}(.*\n)*" "{0,3}"~"{3,}$))
    // does not work
codeinline      "`"[^"`""\n"]+"`"
strong1         "**"[^"**""\n"]+"**"
    //strong1         "**"([^" ""**"][^"**"]*[^" ""**"]|[^" ""**"][^" ""**"]?)"**"
strong2         "__"[^"__""\n"]+"__"
    //strong2         "__"([^" ""__"][^"__"]*[^" ""__"]|[^" ""__"][^" ""__"]?)"__"
strong          ({strong1}|{strong2})
emph1           "*"[^"*""\n"]+"*"
    //emph1           "*"([^" ""*"][^"*"]*[^" ""*"]|[^" ""*"][^" ""*"]?)"*"
emph2           "_"[^"_""\n"]+"_"
    //emph2           "_"([^" ""_"][^"_"]*[^" ""_"]|[^" ""_"][^" ""_"]?)"_"
emph            ({emph1}|{emph2})
strongemph1     "***"[^"***""\n"]+"***"
strongemph2     "___"[^"___""\n"]+"___"
    //strongemph1     "***"([^" ""***"][^"***"]*[^" ""***"]|[^" ""***"][^" ""***"]?)"***"
    //strongemph2     "___"([^" ""___"][^"___"]*[^" ""___"]|[^" ""___"][^" ""___"]?)"___"
strongemph      ({strongemph1}|{strongemph2})
strikethrough   "~~"[^"~~""\n"]+"~~"
    //strikethrough   "~~"([^" ""~~"][^"~~"]*[^" ""~~"]|[^" ""~~"][^" ""~~"]?)"~~"            
        // link can have bold inside
%{
#include "defines.h"
/*
FASE 1
Escape characters

FASE 2
Bloques
h1-6
h1-2setext
line
indent
tables
lists
blockquotes

FASE 3
Inline
html
codeblockind
codeblock
codeinline
strong
emph
strongemph

FASE 4
Escape characters
*/

/**
 * @brief Elimina los primeros 'first' y los últimos 'last' caracteres de 'str'
 *
 * Consideraciones especiales:
 *  - si first < 0 ó last < 0, la función devolverá 'str' tal como es, excepto
 */
char* removeFirstLast(char* str, int first, int last);

void replace(unsigned type, char *text, FILE *out);
%}


%%

    /* ---- Sección de reglas ---- */
    /* WIP CUIDADO INDENTACION EN MIERDAS */

    //{verbatim}      { ECHO; }
<phase2>{
    {verbatim}      { ECHO; }
    {html}          { ECHO; }
    {codeblock1}    { ECHO; }
    {codeblock2}    { ECHO; }
    {codeblockind}  { ECHO; }
    {h1}            { replace(H1, yytext, yyout); }
    {h2}            { replace(H2, yytext, yyout); }
    {h3}            { replace(H3, yytext, yyout); }
    {h4}            { replace(H4, yytext, yyout); }
    {h5}            { replace(H5, yytext, yyout); }
    {h6}            { replace(H6, yytext, yyout); }
    {h1setext}      { replace(H1SETEXT, yytext, yyout); }
    {h2setext}      { replace(H2SETEXT, yytext, yyout); }
    {line}          { replace(LINE, yytext, yyout); }
    {indent}        { replace(INDENT, yytext, yyout); }
    {table}         { replace(TABLE, yytext, yyout); }
    {bullist}       { replace(BULLIST, yytext, yyout); }
    {numlist}       { replace(NUMLIST, yytext, yyout); }
    {blockquote}    { replace(BLOCKQUOTE, yytext, yyout); }
    .               { replace(DEFAULT, yytext, yyout); }
}
<phase3>{
    {verbatim}      { ECHO; }
    {html}          { replace(HTML, yytext, yyout); }
    {codeblock1}    { replace(CODEBLOCK, yytext, yyout); }
    {codeblock2}    { replace(CODEBLOCK, yytext, yyout); }
    {codeblockind}  { replace(CODEBLOCKIND, yytext, yyout); }
    {codeinline}    { replace(CODEINLINE, yytext, yyout); }
    {strong}        { replace(STRONG, yytext, yyout); }
    {emph}          { replace(EMPH, yytext, yyout); }
    {strongemph}    { replace(STRONGEMPH, yytext, yyout); }
    {strikethrough} { replace(STRIKETHROUGH, yytext, yyout); }
    {link}          { replace(LINK, yytext, yyout); }
    .               { replace(DEFAULT, yytext, yyout); }
}

%%

    /* ---- Sección de procedimientos ---- */

int yywrap() {
    return 1;
}

int translate(FILE* stream_read, unsigned phase) {
    // detects the phase of translation
    FILE* stream_write;
    switch (phase) {
        case PHASE1:
            BEGIN(phase1);
            stream_write=fopen(PHASE1OUTPUT,"w");
            break;
        case PHASE2:
            BEGIN(phase2);
            stream_write=fopen(PHASE2OUTPUT,"w");
            break;
        case PHASE3:
            BEGIN(phase3);
            stream_write=fopen(PHASE3OUTPUT,"w");
            break;
        case PHASE4:
            BEGIN(phase4);
            stream_write=fopen(PHASE4OUTPUT,"w");
            break;
        default:
            exit(-1);
    }

    yyin = stream_read;
    yyout = stream_write;

    yylex();

    fclose(stream_write);
    
    return 0;
}

char* removeFirstLast(char *str, int first, int last) {
    for ( int i = 0; i < first; i++ )
        str++;
    
    str[strlen(str)-last] = '\0';
    
    return str;
}

void replace(unsigned type, char *text, FILE *out) {
    char *str;
    //WIPprintf("Lex executed\n");
    switch(type) {
        case H1:
            fprintf(out, "{{h1}}%s{{/h1}}", removeFirstLast(text, 2, 0));
            break;
        case H2:
            fprintf(out, "{{h2}}%s{{/h2}}", removeFirstLast(text, 3, 0));
            break;
        case H3:
            fprintf(out, "{{h3}}%s{{/h3}}", removeFirstLast(text, 4, 0));
            break;
        case H4:
            fprintf(out, "{{h4}}%s{{/h4}}", removeFirstLast(text, 5, 0));
            break;
        case H5:
            fprintf(out, "{{h5}}%s{{/h5}}", removeFirstLast(text, 6, 0));
            break;
        case H6:
            fprintf(out, "{{h6}}%s{{/h6}}", removeFirstLast(text, 7, 0));
            break;
        case H1SETEXT:
            ; // find the last \n and delete that part
            str = yytext;
            for ( int i = strlen(str) - 1; i >= 0; i-- ) {
                if ( str[i] == '\n' ) {
                    str[i] = '\0';
                    i = -1;
                }
            }
            fprintf(out, "{{h1set}}%s{{/h1set}}", text);
            break;
        case H2SETEXT:
            ; // find the last \n and delete that part
            str = yytext;
            for ( int i = strlen(str) - 1; i >= 0; i-- ) {
                if ( str[i] == '\n' ) {
                    str[i] = '\0';
                    i = -1;
                }
            }
            fprintf(out, "{{h2set}}%s{{/h2set}}", text);
            break;
        case LINE:
            fprintf(out, "{{line}}");
            break;
        case INDENT:
            fprintf(out, "{{indent}}%s", removeFirstLast(text, 4, 0));
            break;
        case TABLE:
            fprintf(out, "{{table}}%s{{/table}}\n", removeFirstLast(text, 0, 1));
            break;
        case BULLIST:
            fprintf(out, "{{bullist}}%s{{/bullist}}", text);
            break;
        case NUMLIST:
            fprintf(out, "{{numlist}}%s{{/numlist}}", text);
            break;
        case BLOCKQUOTE:
            fprintf(out, "{{blockquote}}%s{{/blockquote}}", text);
            break;
        case LINK:
            fprintf(out, "{{link}}%s{{/link}}", text);
            break;
        case HTML:
            fprintf(out, "{{html}}%s{{/html}}", text);
            break;
        case CODEBLOCKIND:
            fprintf(out, "{{codeind}}%s{{/codeind}}", text);
            break;
        case CODEBLOCK:
            fprintf(out, "{{codeblock}}%s{{/codeblock}}", removeFirstLast(text, 3, 3));
            break;
        case CODEINLINE:
            fprintf(out, "{{code}}%s{{/code}}", removeFirstLast(text, 1, 1));
            break;
        case STRONG:
            fprintf(out, "{{strong}}%s{{/strong}}", removeFirstLast(text, 2, 2));
            break;
        case EMPH:
            fprintf(out, "{{emph}}%s{{/emph}}", removeFirstLast(text, 1, 1));
            break;
        case STRONGEMPH:
            fprintf(out, "{{strongemph}}%s{{/strongemph}}", removeFirstLast(text, 3, 3));
            break;
        case STRIKETHROUGH:
            fprintf(out, "{{strikethrough}}%s{{/strikethrough}}", removeFirstLast(text, 2, 2));
            break;
        default:
            fprintf(out, "%s", text);
    }
}