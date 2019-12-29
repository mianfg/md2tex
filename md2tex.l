    /* ---- Declarations section ---- */

    // Translation phases

%s phase1
%s phase2
%s phase3
%s phase4

    // Regular expressions

escapebs        "\\\\"
escapebt        "\\`"
escapeas        "\\*"
escapeun        "\\_"
escapecu1       "\\{"
escapecu2       "\\}"
escapesb1       "\\\["
escapesb2       "\\\]"
escapepa1       "\\\("
escapepa2       "\\\)"
escapeha        "\\#"
escapepl        "\\+"
escapemi        "\\-"
escapedo        "\\."
escapeex        "\\!"

verbatim        ^"$$"[."\n"]*"$$"
html            ("<".+">".*(.*\n)*"</".+">"|"<!".*(.*\n)*">")
h1              ^" "{0,3}"# ".*$
h2              ^" "{0,3}"## ".*$
h3              ^" "{0,3}"### ".*$
h4              ^" "{0,3}"#### ".*$
h5              ^" "{0,3}"##### ".*$
h6              ^" "{0,3}"###### ".*$
h1setext        ^(.+\n)+" "{0,3}"="+$
h2setext        ^(.+\n)+" "{0,3}"-"+$
line1           " "{0,3}"*"" "*"*"" "*"*"" "*[" ""*"]*
line2           " "{0,3}"-"" "*"-"" "*"-"" "*[" ""-"]*
line3           " "{0,3}"_"" "*"_"" "*"_"" "*[" ""_"]*
line            ^({line1}|{line2}|{line3})$
image           ^(" "|"\t")*"!"{link}(" "|"\t")*$
tableh          " "*"| "(.*" | ").*" |"" "*"\n"
tables          " "*"|"(" "*":"?[" ""\-"]*"-"[" ""\-"]*":"?" "*"|")+" "*"\n"
table           ^{tableh}{tables}{tableh}*
bullist         ^(" "{0,3}["*""+""\-"](" "|"\t").*\n)+
numlist         ^(" "{0,3}[0-9]+"."(" "|"\t").*\n)+
blockfirst      " "{0,3}">".*"\n"
blocknext       .+\n
blockquote      ^{blockfirst}{blocknext}*
indent          ^((" "{4,4}|"\t").*\n)+
codeblock1      ^"`"{3,}(.*\n)([^"`""``""```"].*\n)*" "{0,3}"`"{3,}" "*$
codeblock2      ^"~"{3,}(.*\n)([^"~""~~""~~~"].*\n)*" "{0,3}"~"{3,}" "*$
codeinline      "`"[^"`""\n"]+"`"
strong1         "**"[^"**""\n"]+"**"
strong2         "__"[^"__""\n"]+"__"
strong          ({strong1}|{strong2})
emph1           "*"[^"*""\n"]+"*"
emph2           "_"[^"_""\n"]+"_"
emph            ({emph1}|{emph2})
strongemph1     "***"[^"***""\n"]+"***"
strongemph2     "___"[^"___""\n"]+"___"
strongemph      ({strongemph1}|{strongemph2})
strikethrough   "~~"[^"~~""\n"]+"~~"
link            "\["[^"\[""\]""\n"]+"\]""\("[^"\(""\)""\n"]+"\)"

restoreescapebs     ("\\""\\""ESCAPE""\\")"|"("\\""\\")
restoreescapebt     ("\\""\\""ESCAPE""\\")"`"("\\""\\") 
restoreescapeas     ("\\""\\""ESCAPE""\\")"*"("\\""\\") 
restoreescapeun     ("\\""\\""ESCAPE""\\")"_"("\\""\\") 
restoreescapecu1    ("\\""\\""ESCAPE""\\")"{"("\\""\\")
restoreescapecu2    ("\\""\\""ESCAPE""\\")"}"("\\""\\")
restoreescapesb1    ("\\""\\""ESCAPE""\\")"["("\\""\\")
restoreescapesb2    ("\\""\\""ESCAPE""\\")"]"("\\""\\")
restoreescapepa1    ("\\""\\""ESCAPE""\\")"("("\\""\\")
restoreescapepa2    ("\\""\\""ESCAPE""\\")")"("\\""\\")
restoreescapeha     ("\\""\\""ESCAPE""\\")"#"("\\""\\") 
restoreescapepl     ("\\""\\""ESCAPE""\\")"+"("\\""\\") 
restoreescapemi     ("\\""\\""ESCAPE""\\")"-"("\\""\\") 
restoreescapedo     ("\\""\\""ESCAPE""\\")"."("\\""\\") 
restoreescapeex     ("\\""\\""ESCAPE""\\")"!"("\\""\\") 

%{
/**
 * @file md2tex.l
 * @author Miguel Ángel Fernández Gutiérrez (https://mianfg.bloomgogo.com/)
 * @date 29 Dec 2019
 * @brief File containing Lex routines and instructions
 * 
 * This file contains the regular expressions that will parse the various
 * markdown commands, and then translate them to LaTeX
 */
#include "defines.h"
#include "latexcommands.h"
#include <stdbool.h>

/**
 * @brief Removes first 'first' and last 'last' characters from 'str'
 */
char* removeFirstLast(char* str, int first, int last);

/**
 * @brief Main function for replacing output
 * This is the md to tex translator!
 */
void replace(unsigned type, char *text, FILE *out);
%}


%%

    /* ---- Sección de reglas ---- */

<phase1>{
    {escapebs}      { fprintf(yyout, ESCAPEBS); }
    {escapebt}      { fprintf(yyout, ESCAPEBT); }
    {escapeas}      { fprintf(yyout, ESCAPEAS); }
    {escapeun}      { fprintf(yyout, ESCAPEUN); }
    {escapecu1}     { fprintf(yyout, ESCAPECU1); }
    {escapecu2}     { fprintf(yyout, ESCAPECU2); }
    {escapesb1}     { fprintf(yyout, ESCAPESB1); }
    {escapesb2}     { fprintf(yyout, ESCAPESB2); }
    {escapepa1}     { fprintf(yyout, ESCAPEPA1); }
    {escapepa2}     { fprintf(yyout, ESCAPEPA2); }
    {escapeha}      { fprintf(yyout, ESCAPEHA); }
    {escapepl}      { fprintf(yyout, ESCAPEPL); }
    {escapemi}      { fprintf(yyout, ESCAPEMI); }
    {escapedo}      { fprintf(yyout, ESCAPEDO); }
    {escapeex}      { fprintf(yyout, ESCAPEEX); }
}
<phase2>{
    {verbatim}      { ECHO; }
    {html}          { ECHO; }
    {codeblock1}    { ECHO; }
    {codeblock2}    { ECHO; }
    {h1}            { replace(H1, yytext, yyout); }
    {h2}            { replace(H2, yytext, yyout); }
    {h3}            { replace(H3, yytext, yyout); }
    {h4}            { replace(H4, yytext, yyout); }
    {h5}            { replace(H5, yytext, yyout); }
    {h6}            { replace(H6, yytext, yyout); }
    {h1setext}      { replace(H1SETEXT, yytext, yyout); }
    {h2setext}      { replace(H2SETEXT, yytext, yyout); }
    {line}          { replace(LINE, yytext, yyout); }
    {image}         { replace(IMAGE, yytext, yyout); }
    {table}         { replace(TABLE, yytext, yyout); }
    {bullist}       { replace(BULLIST, yytext, yyout); }
    {numlist}       { replace(NUMLIST, yytext, yyout); }
    {blockquote}    { replace(BLOCKQUOTE, yytext, yyout); }
    {indent}        { replace(INDENT, yytext, yyout); }
    .               { replace(DEFAULT, yytext, yyout); }
}
<phase3>{
    {verbatim}      { ECHO; }
    {html}          { replace(HTML, yytext, yyout); }
    {codeblock1}    { replace(CODEBLOCK, yytext, yyout); }
    {codeblock2}    { replace(CODEBLOCK, yytext, yyout); }
    {codeinline}    { replace(CODEINLINE, yytext, yyout); }
    {strong}        { replace(STRONG, yytext, yyout); }
    {emph}          { replace(EMPH, yytext, yyout); }
    {strongemph}    { replace(STRONGEMPH, yytext, yyout); }
    {strikethrough} { replace(STRIKETHROUGH, yytext, yyout); }
    {link}          { replace(LINK, yytext, yyout); }
    .               { replace(DEFAULT, yytext, yyout); }
}
<phase4>{
    {verbatim}          { replace(VERBATIM, yytext, yyout); }
    {restoreescapebs}   { fprintf(yyout, "\\"); }
    {restoreescapebt}   { fprintf(yyout, "`"); }
    {restoreescapeas}   { fprintf(yyout, "*"); }
    {restoreescapeun}   { fprintf(yyout, "\\_"); }
    {restoreescapecu1}  { fprintf(yyout, "{"); }
    {restoreescapecu2}  { fprintf(yyout, "}"); }
    {restoreescapesb1}  { fprintf(yyout, "["); }
    {restoreescapesb2}  { fprintf(yyout, "]"); }
    {restoreescapepa1}  { fprintf(yyout, "("); }
    {restoreescapepa2}  { fprintf(yyout, ")"); }
    {restoreescapeha}   { fprintf(yyout, "#"); }
    {restoreescapepl}   { fprintf(yyout, "+"); }
    {restoreescapemi}   { fprintf(yyout, "-"); }
    {restoreescapedo}   { fprintf(yyout, "."); }
    {restoreescapeex}   { fprintf(yyout, "!"); }
    "_"                 { fprintf(yyout, "\\_"); }
}

%%

    /* ---- Procedures section ---- */

int yywrap() {
    return 1;
}

void header_message(FILE* stream_write, char* output_filename) {
    fprintf(stream_write, "%% %s\n", output_filename);
    fprintf(stream_write, "%% ---------------------------------------------------\n");
    fprintf(stream_write, "%% This file has been generated using md2tex\n");
    fprintf(stream_write, "%%     https://github.com/mianfg/md2tex\n");
    fprintf(stream_write, "%%\n");
    fprintf(stream_write, "%% Author: Miguel Ángel Fernández Gutiérrez (@mianfg)\n");
    fprintf(stream_write, "%% ---------------------------------------------------\n\n\n");
}

int translate(FILE* stream_read, char* output_name, unsigned phase) {
    FILE* stream_write;

    stream_write=fopen(output_name,"w");
    yyin = stream_read;
    yyout = stream_write;

    // retrieves phase of translation
    switch (phase) {
        case PHASE1:
            BEGIN(phase1);
            break;
        case PHASE2:
            BEGIN(phase2);
            break;
        case PHASE3:
            BEGIN(phase3);
            break;
        case PHASE4:
            BEGIN(phase4);
            header_message(stream_write, output_name);
            break;
        default:
            exit(-1);
    }

    // executes lexer
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

/** @note
 * These variables are globally declared due to the intensive use.
 * This could have been managed using malloc, but I deemed it unnecessary
 */

char alignments[MAX_COLUMNS] = "";
    // maximum number of columns in a table
char number[MAX_NUMBERS] = "";
    // maximum number of digits of a number in number list

void replace(unsigned type, char *text, FILE *out) {
    char *str;

    switch(type) {
        case VERBATIM:
            fprintf(out, "%s", removeFirstLast(text, 2, 2));
            break;
        case HTML:
            fprintf(out, "%s%s%s",
                HTMLBEGIN,
                text,
                HTMLEND
            );
            break;
        case H1:
            fprintf(out, "%s%s%s",
                H1BEGIN,
                removeFirstLast(text, 2, 0),
                H1END
            );
            break;
        case H2:
            fprintf(out, "%s%s%s",
                H2BEGIN,
                removeFirstLast(text, 3, 0),
                H2END
            );
            break;
        case H3:
            fprintf(out, "%s%s%s",
                H3BEGIN,
                removeFirstLast(text, 4, 0),
                H3END
            );
            break;
        case H4:
            fprintf(out, "%s%s%s",
                H4BEGIN,
                removeFirstLast(text, 5, 0),
                H4END
            );
            break;
        case H5:
            fprintf(out, "%s%s%s",
                H5BEGIN,
                removeFirstLast(text, 6, 0),
                H5END
            );
            break;
        case H6:
            fprintf(out, "%s%s%s",
                H6BEGIN,
                removeFirstLast(text, 7, 0),
                H6END
            );
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
            fprintf(out, "%s%s%s",
                H1SETEXTBEGIN,
                text,
                H1SETEXTEND
            );
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
            fprintf(out, "%s%s%s",
                H2SETEXTBEGIN,
                text,
                H2SETEXTEND
            );
            break;
        case LINE:
            fprintf(out, LINECONTENT);
            break;
        case IMAGE:
            fprintf(out, "%s", BEGINIMAGE);
            // print image location part
            bool print = false;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( text[i] == ')' ) {
                    print = false;
                    i = strlen(text);   // end for
                }
                if ( print )
                    fprintf(out, "%c", text[i]);
                if ( text[i] == '(' )
                    print = true;
            }
            fprintf(out, "%s", BEGINCAPTION);
            // print caption
            print = false;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( text[i] == ']' ) {
                    print = false;
                    i = strlen(text);   // end for
                }
                if ( print )
                    fprintf(out, "%c", text[i]);
                if ( text[i] == '[' )
                    print = true;
            }
            fprintf(out, "%s", ENDIMAGE);
            break;
        case TABLE:
            ;
            alignments[0] = '\0';
            int columns = 0, columns_temp = 0, column_number = -1, column_type = 0;
            int lastbar = -1;
            int line = 0;    // 0: header, 1: separator, 2+: body
            bool hasreaddash = false, hasreadcolon = false;
            
            // replace table body
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( line == 0 || line >= 2 ) {
                    if ( text[i] == '|' ) {
                        if ( lastbar == -1 )
                            text[i] = '\n';
                        else {
                            text[i] = '&';
                            columns_temp++;
                        }
                        lastbar = i;
                    } else if ( text[i] == '\n' ) {
                        line++;
                        text[lastbar] = '\\';
                        text[lastbar+1] = '\\';
                        lastbar = -1;
                        if ( columns_temp > columns )
                            columns = columns_temp;
                        columns_temp = 0;
                    }
                } else if ( line == 1 ) {
                    if ( text[i] == '|' ) {
                        if ( column_number >= 0 ) {
                            if ( !hasreadcolon )
                                column_type = -2;
                            
                            switch(column_type) {
                                case 0:
                                    alignments[column_number] = 'c';
                                    break;
                                case 1:
                                    alignments[column_number] = 'r';
                                    break;
                                case -1:
                                    alignments[column_number] = 'l';
                                    break;
                                default:
                                    alignments[column_number] = 'l';
                                    // by default will be left
                            }
                        }
                        column_number++;
                        hasreaddash = false;
                        hasreadcolon = false;
                        column_type = 0;
                    } else if ( text[i] == '-' ) {
                        hasreaddash = true;
                    } else if ( text[i] == ':' ) {
                        hasreadcolon = true;
                        if ( hasreaddash )
                            column_type++;
                        else
                            column_type--;
                    } else if ( text[i] == '\n' ) {
                        alignments[column_number] = '\0';
                        line++;
                    }
                    text[i] = ' ';  // WIP delete characters straight ahead
                }
            }

            // now we have:
                // alignments: array with alignments
                // columns: number of columns of table (maximum of all)
                // text modified so that it is the interior of the table directive
            
            // complete the alignments with left alignments to complete columns
            for ( int i = strlen(alignments); i < columns; i++ )
                alignments[i] = 'l';
            alignments[columns] = '\0';

            fprintf(out, "%s%s%s%s%s\n",
                THEADERBEFOREALIGN,
                alignments,
                THEADERAFTERALIGN,
                text,
                TFOOTER
            );
            break;
        case BULLIST:
            fprintf(out, "%s\n", BULLISTHEADER);
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( text[i] == '*' || text[i] == '-' || text[i] == '+' )
                    fprintf(out, "\\item");
                else
                    fprintf(out, "%c", text[i]);
            }
            fprintf(out, "%s\n", BULLISTFOOTER);
            break;
        case NUMLIST:
            /**
             * @note
             * This function uses atoi, not recommended for use in production.
             * However, the behavior of this function is known at all times,
             * hence atoi will not cause any failure.
             */
            ;
            number[0] = '\0';
            int readnumber = -1;
            fprintf(out, "%s\n", NUMLISTHEADER);
            bool readnumbers = true;
            int startnumber = -1;
            int expectednumber = -2;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( readnumbers ) {
                    if ( text[i] >= '0' && text[i] <= '9' ) {
                        int len = strlen(number);
                        number[len+1] = '\0';
                        number[len] = text[i];
                    } else if ( text[i] == '.' ) {
                        readnumber = atoi(number);
                        expectednumber++;
                        if ( startnumber < 0 ) {
                            startnumber = readnumber;
                            expectednumber = startnumber;
                            if ( startnumber > 1 )
                                fprintf(out, "\\setcounter{enumi}{%d}\n", startnumber-1);
                            fprintf(out, "\\item");
                        } else
                            if ( expectednumber == readnumber )
                                fprintf(out, "\\item");
                            else
                                fprintf(out, "\\item[%d.]", readnumber);
                        readnumbers = false;
                        
                        number[0] = '\0';
                    } else {
                        fprintf(out, "%c", text[i]);
                    }
                } else {
                    fprintf(out, "%c", text[i]);
                    if ( text[i] == '\n' ) {
                        readnumbers = true;
                    }
                }
            }
            fprintf(out, "%s\n", NUMLISTFOOTER);
            break;
        case BLOCKQUOTE:
            fprintf(out, "%s\n", BLOCKQUOTEHEADER);
            bool found = false;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( text[i] == '>' && !found )
                    found = true;
                else
                    fprintf(out, "%c", text[i]);
                if ( text[i] == '\n' )
                    found = false;
            }
            fprintf(out, "%s\n", BLOCKQUOTEFOOTER);
            break;
        case INDENT:
            fprintf(out, "%s\n", INDENTHEADER);
            bool linebegin = true;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( linebegin ) {
                    // ignore tab, ignore four spaces by skipping next 3
                    if ( text[i] = ' ' )
                        i += 3;
                    linebegin = false;
                } else
                    fprintf(out, "%c", text[i]);
                if ( text[i] == '\n' )
                    linebegin = true;
            }
            fprintf(out, "%s\n", INDENTFOOTER);
            break;
        case CODEBLOCK:
            fprintf(out, "%s", CBHEADER);
            int i = 0;
            char marker = text[0];
            bool foundmarker = false;
            while ( i < strlen(text) ) {
                if ( text[i] != marker )
                    break;
                i++;
            }
            while ( text[i] != '\n' ) {
                fprintf(out, "%c", text[i]);
                i++;
            }
            fprintf(out, "%s", CBAFTERLANG);
            
            // find last \n and alter character right next
            int lastendl = -1;
            for ( int j = strlen(text)-1; j >= 0; j-- ) {
                if ( text[j] == '\n' ) {
                    lastendl = j;
                    j = -1;
                }
            }

            for ( i; i < lastendl; i++ )
                fprintf(out, "%c", text[i]);
            
            fprintf(out, "\n%s", CBFOOTER);
            break;
        case CODEINLINE:
            fprintf(out, "%s%s%s",
                CODEINLINEBEGIN,
                removeFirstLast(text, 1, 1),
                CODEINLINEEND
            );
            break;
        case STRONG:
            fprintf(out, "%s%s%s",
                STRONGBEGIN,
                removeFirstLast(text, 2, 2),
                STRONGEND
            );
            break;
        case EMPH:
            fprintf(out, "%s%s%s",
                EMPHBEGIN,
                removeFirstLast(text, 1, 1),
                EMPHEND
            );
            break;
        case STRONGEMPH:
            fprintf(out, "%s%s%s",
                STRONGEMPHBEGIN,
                removeFirstLast(text, 3, 3),
                STRONGEMPHEND
            );
            break;
        case STRIKETHROUGH:
            fprintf(out, "%s%s%s",
                STRIKETHROUGHBEGIN,
                removeFirstLast(text, 2, 2),
                STRIKETHROUGHEND
            );
            break;
        case LINK:
            fprintf(out, "%s", LINKBEGIN);
            // print URL part
            print = false;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( text[i] == ')' ) {
                    print = false;
                    i = strlen(text);   // end for
                }
                if ( print )
                    fprintf(out, "%c", text[i]);
                if ( text[i] == '(' )
                    print = true;
            }
            fprintf(out, "%s", LINKCENTER);
            // print text
            print = false;
            for ( int i = 0; i < strlen(text); i++ ) {
                if ( text[i] == ']' ) {
                    print = false;
                    i = strlen(text);   // end for
                }
                if ( print )
                    fprintf(out, "%c", text[i]);
                if ( text[i] == '[' )
                    print = true;
            }
            fprintf(out, "%s", LINKEND);
            break;
        default:
            fprintf(out, "%s", text);
    }
}