/**
 * @file latexcommands.h
 * @author Miguel Ángel Fernández Gutiérrez (https://mianfg.bloomgogo.com/)
 * @date 29 Dec 2019
 * @brief File containing LaTeX command substitution instructions
 * 
 * This file specifies the LaTeX commands that will be used in translation.
 * The format of the substitution is specified in each.
 * 
 * Please note that the output of md2tex does not include the imports of the
 * necessary libraries, please modify this file as you might to use your own
 * components, libraries and style!
 * 
 * {command}    is the content inside the markdown delimiters, where no
 *              speficication is needed
 */

/**
 * HTML
 * Will be replaced by {HTMLBEGIN}{content}{HTMLEND}
 */
#define HTMLBEGIN   "\\begin{lstlisting}[language=HTML]\n"
#define HTMLEND     "\n\\end{lstlisting}"

/**
 * H1
 * Will be replaced by {H1BEGIN}{content}{H1END}
 */
#define H1BEGIN     "\\part{"
#define H1END       "}"

/**
 * H2
 * Will be replaced by {H2BEGIN}{content}{H2END}
 */
#define H2BEGIN     "\\chapter{"
#define H2END       "}"

/**
 * H3
 * Will be replaced by {H3BEGIN}{content}{H3END}
 */
#define H3BEGIN     "\\section{"
#define H3END       "}"

/**
 * H4
 * Will be replaced by {H4BEGIN}{content}{H4END}
 */
#define H4BEGIN     "\\subsection{"
#define H4END       "}"

/**
 * H5
 * Will be replaced by {H5BEGIN}{content}{H5END}
 */
#define H5BEGIN     "\\subsubsection{"
#define H5END       "}"

/**
 * H6
 * Will be replaced by {H6BEGIN}{content}{H6END}
 */
#define H6BEGIN     "\\paragraph{"
#define H6END       "}"

/**
 * H1SETEXT
 * Will be replaced by {H1SETEXTBEGIN}{content}{H1SETEXTEND}
 */
#define H1SETEXTBEGIN   "\\section{"
#define H1SETEXTEND     "}"

/**
 * H2SETEXT
 * Will be replaced by {H2SETEXTBEGIN}{content}{H2SETEXTEND}
 */
#define H2SETEXTBEGIN   "\\subsection{"
#define H2SETEXTEND     "}"

/**
 * LINE
 * Will be replaced by {LINECONTENT}
 */
#define LINECONTENT     "\\par\\noindent\\rule{\\textwidth}{0.4pt}"

/**
 * IMAGE
 * Will be replaced by {BEGINIMAGE}{imageurl}{BEGINCAPTION}{caption}{ENDIMAGE}
 */
#define BEGINIMAGE      "\\begin{figure}[h]\n\\centering\n\\includegraphics[width=0.5\\textwidth]{"
#define BEGINCAPTION    "}\n\\caption{"
#define ENDIMAGE        "}\n\\end{figure}"

/**
 * TABLE
 * Will be replaced by {THEADERBEFOREALIGN}{alignment}{THEADERAFTERALIGN}{tablecontent}{TFOOTER}, where:
 *     {alignment}     is the table alignment, in the format {type}, as many
 *                     times as columns there are ({type} is l, c or r)
 *     {tablecontent}  is the table content in the format
 *                         {content}&...&{content}\\,
 *                     as many times as rows there are (including first row)
 */
#define THEADERBEFOREALIGN  "\\begin{table}[]\n\\begin{tabular}{"
#define THEADERAFTERALIGN   "}"
#define TFOOTER             "\n\\end{tabular}\n\\end{table}"

/**
 * BULLIST
 * Will be replaced by {BULLISTHEADER}{bullistcontent}{BULLISTFOOTER}, where:
 *     {bullistcontent}    is the content of the bullet list, with \item in
 *                         place of the bullets
 */
#define BULLISTHEADER   "\\begin{itemize}"
#define BULLISTFOOTER   "\\end{itemize}"

/**
 * NUMLIST
 * Will be replaced by {NUMLISTHEADER}{numlistcontent}{NUMLISTFOOTER}, where:
 *     {numlistcontent}    is the content of the numbered list, with \item or
 *                         \item[{number}.] in place of the numbers.
 *                         The list will start with the numeration starter
 *                         \setcounter if it does not start with 1
 */
#define NUMLISTHEADER   "\\begin{enumerate}"
#define NUMLISTFOOTER   "\\end{enumerate}"

/**
 * BLOCKQUOTE
 * Will be replaced by {BLOCKQUOTEHEADER}{content}{BLOCKQUOTEFOOTER}
 */
#define BLOCKQUOTEHEADER    "\\begin{displayquote}"
#define BLOCKQUOTEFOOTER    "\\end{displayquote}"

/**
 * INDENT
 * Will be replaced by {INDENTHEADER}{content}{INDENTFOOTER}
 */
#define INDENTHEADER    "\\begin{forceindent}"
#define INDENTFOOTER    "\\end{forceindent}"

/**
 * CODEBLOCK
 * Will be replaced by {CBHEADER}{language}{CBAFTERLANG}{content}{CBFOOTER},
 * where:
 *     {language}  is the language specified in the markdown codeblock command
 */
#define CBHEADER    "\\begin{lstlisting}[language="
#define CBAFTERLANG "]"
#define CBFOOTER    "\\end{lstlisting}"

/**
 * CODEINLINE
 * Will be replaced by {CODEINLINEBEGIN}{content}{CODEINLINEEND}
 */
#define CODEINLINEBEGIN "\\lstinline{"
#define CODEINLINEEND   "}"

/**
 * STRONG
 * Will be replaced by {STRONGBEGIN}{content}{STRONGEND}
 */
#define STRONGBEGIN "\\textbf{"
#define STRONGEND   "}"

/**
 * EMPH
 * Will be replaced by {EMPHBEGIN}{content}{EMPHEND}
 */
#define EMPHBEGIN   "\\emph{"
#define EMPHEND     "}"

/**
 * STRONGEMPH
 * Will be replaced by {STRONGEMPHBEGIN}{content}{STRONGEMPHEND}
 */
#define STRONGEMPHBEGIN "\\textbf{\\emph{{"
#define STRONGEMPHEND   "}}"

/**
 * STRIKETHROUGH
 * Will be replaced by {STRIKETHROUGHBEGIN}{content}{STRIKETHROUGHEND}
 */
#define STRIKETHROUGHBEGIN  "\\st{"
#define STRIKETHROUGHEND    "}"

/**
 * LINK
 * Will be replaced by {LINKBEGIN}{url}{LINKCENTER}{text}{LINKEND}, where:
 *     {url}   is the URL specified in the markdown command
 *     {text}  is the text that will be shown as hyperlink, as specified in the
 *             markdown command specification
 */
#define LINKBEGIN   "\\href{"
#define LINKCENTER  "}{"
#define LINKEND     "}"