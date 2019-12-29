/**
 * @file md2tex.c
 * @author Miguel Ángel Fernández Gutiérrez (https://mianfg.bloomgogo.com/)
 * @date 29 Dec 2019
 * @brief Main script for md2tex
 * 
 * This scripts translates a markdown file, as plain text, to a latex file.
 * 
 * CALLING
 * -------
 * To execute the program, simply do:
 *      $ ./md2tex {inputfilename} [--preserve]
 * 
 * --preserve : optional command
 *      Preserve intermediary files (for each translation phase)
 * 
 * OUTPUT
 * ------
 * The output file will be of the form:
 *      {inputfilename}_md2tex.tex
 * 
 * SOME CONSIDERATIONS
 * -------------------
 * Please note that, in order to execute this script, md2tex.l must be
 * "translated" to C. To do that, simply execute the command:
 *      $ lex md2tex.l
 */
#include "lex.yy.c"
#include "defines.h"
#include <stdbool.h>

int main(int argc, char**argv) {
    bool preserve = false;
    char* filename;
    char output[MAX_FILENAME];
    FILE* stream;
    // detects file
    if ( argc == 2 )
        filename = argv[1];
    else if ( argc == 3 ) {
        filename = argv[1];
        preserve = true;
    } else {
        printf("You haven't called this program correctly.\n\n");
        printf("\t./md2tex {inputfilename} [--preserve]\n");
        printf("\t\tpreserve : preserve intermediary files\n");
        exit(EXIT_FAILURE);
    }

    // phase 1 of translation
    stream = fopen(filename, "rt");
    if ( stream == NULL ) {
        printf("[ERROR] Could not open file %s\n", filename);
        exit(EXIT_FAILURE);
    }
    char* extension = ".md";
    int j = strlen(extension)-1;
    // remove .md extension, if it appears
    for ( int i = strlen(filename)-1; i >= 0; i-- ) {
        if ( filename[i] == extension[j] )  j--;
        else  i = -1;

        if ( j < 0 ) {
            filename[i] = '\0';
            i = -1;
        }
    }
    sprintf(output, "%s%s", filename, PHASE1OUTPUT);
    if ( translate(stream, output, PHASE1) != 0 ) {
        printf("[ERROR] Error in phase 1 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    fclose(stream);

    // phase 2 of translation
    stream = fopen(output, "rt");
    if ( stream == NULL ) {
        printf("[ERROR] Error opening file for phase 2 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    sprintf(output, "%s%s", filename, PHASE2OUTPUT);
    if ( translate(stream, output, PHASE2) != 0 ) {
        printf("[ERROR] Error in phase 2 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    fclose(stream);
    
    // phase 3 of translation
    stream = fopen(output, "rt");
    if ( stream == NULL ) {
        printf("[ERROR] Error opening file for phase 3 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    sprintf(output, "%s%s", filename, PHASE3OUTPUT);
    if ( translate(stream, output, PHASE3) != 0 ) {
        printf("[ERROR] Error in phase 3 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    fclose(stream);

    // phase 4 of translation
    stream = fopen(output, "rt");
    if ( stream == NULL ) {
        printf("[ERROR] Error opening file for phase 4 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    sprintf(output, "%s%s", filename, PHASE4OUTPUT);
    if ( translate(stream, output, PHASE4) != 0 ) {
        printf("[ERROR] Error in phase 4 of translation, aborting...\n");
        exit(EXIT_FAILURE);
    }
    fclose(stream);
    
    printf("[SUCCESS] Translation finished in %s\n", output);

    if ( !preserve ) {
        sprintf(output, "%s%s", filename, PHASE1OUTPUT);
        if ( remove(output) != 0 )
            printf("[ERROR] Error removing intermediary file %s (phase 1)\n",
                output);
        sprintf(output, "%s%s", filename, PHASE2OUTPUT);
        if ( remove(output) != 0 )
            printf("[ERROR] Error removing intermediary file %s (phase 2)\n",
                output);
        sprintf(output, "%s%s", filename, PHASE3OUTPUT);
        if ( remove(output) != 0 )
            printf("[ERROR] Error removing intermediary file %s (phase 3)\n",
                output);
    }
    
    return EXIT_SUCCESS;
}