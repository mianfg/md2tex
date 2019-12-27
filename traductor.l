    /* ---- Sección de declaraciones ---- */

h1          ^" "{0,3}"# ".*$
h2          ^" "{0,3}"## ".*$
h3          ^" "{0,3}"### ".*$
h4          ^" "{0,3}"#### ".*$
h5          ^" "{0,3}"##### ".*$
h6          ^" "{0,3}"###### ".*$
h1setext
h2setext
codeblock       code block fenced
codeblockind    code block indented
strong      ("**"[^ ].*[^ ]"**"|"__"[^ ].*[^ ]"__")
em          ("*"[^ "*""_"].*[^ "*""_"]"*"|"_"[^ "_""*"].*[^ "_""*"]"_")
line        (^" "{0,3}"*"" "*"*"" "*"*"" "*[" ""*"]*$|^" "{0,3}"-"" "*"-"" "*"-"" "*[" ""-"]*$|^" "{0,3}"_"" "*"_"" "*"_"" "*[" ""_"]*$)

%{
#define DEFAULT 0
#define H1      1
#define H2      2
#define H3      3
#define H4      4
#define H5      5
#define H6      6
#define STRONG  7
#define EM      8
#define LINE    9
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

{h1}        { replace(H1, yytext, yyout); }
{h2}        { replace(H2, yytext, yyout); }
{h3}        { replace(H3, yytext, yyout); }
{h4}        { replace(H4, yytext, yyout); }
{h5}        { replace(H5, yytext, yyout); }
{h6}        { replace(H6, yytext, yyout); }
{strong}    { replace(STRONG, yytext, yyout); }
{em}        { replace(EM, yytext, yyout); }
{line}      { replace(LINE, yytext, yyout); }
.           { replace(DEFAULT, yytext, yyout); }

%%

    /* ---- Sección de procedimientos ---- */

int yywrap() {
    return 1;
}

int main(int argc, char** argv) {
    if ( argc == 2 ) {
        yyin = fopen(argv[1], "rt");
        if ( yyin == NULL ) {
            printf("El fichero %s no se puede abrir\n", argv[1]);
            exit(-1);
        }
    } else
        yyin = stdin;
    yyout=fopen("output","w");

    yylex();
    return 0;
}

char* removeFirstLast(char* str, int first, int last) {
    for ( int i = 0; i < first; i++ )
        str++;
    
    str[strlen(str)-last] = '\0';
    
    return str;
}

void replace(unsigned type, char* text, FILE* out) {
    switch(type) {
        case H1:
            fprintf(out, "<h1>%s</h1>", removeFirstLast(text, 2, 0));
            break;
        case H2:
            fprintf(out, "<h2>%s</h2>", removeFirstLast(text, 3, 0));
            break;
        case H3:
            fprintf(out, "<h3>%s</h3>", removeFirstLast(text, 4, 0));
            break;
        case H4:
            fprintf(out, "<h4>%s</h4>", removeFirstLast(text, 5, 0));
            break;
        case H5:
            fprintf(out, "<h5>%s</h5>", removeFirstLast(text, 6, 0));
            break;
        case H6:
            fprintf(out, "<h6>%s</h6>", removeFirstLast(text, 7, 0));
            break;
        case STRONG:
            fprintf(out, "<str>%s</str>", removeFirstLast(text, 2, 2));
            break;
        case EM:
            fprintf(out, "<em>%s</em>", removeFirstLast(text, 1, 1));
            break;
        case LINE:
            fprintf(out, "<line>");
            break;
        default:
            fprintf(out, "%s", yytext);
    }
}