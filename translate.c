#include "lex.yy.c"     // hacer antes
                        //  $ lex translate_phases.l
#include "defines.h"


int main(int argc, char**argv) {
    char* filename;
    FILE* stream;
    // detects file
    if ( argc == 2 )
        filename = argv[1];
    else {
        printf("Debe insertar un nombre de archivo válido");
        exit(-1);
    }

    // phase 1 of translation
    // ...
    // phase 2 of translation
    // open
    stream = fopen(filename, "rt");
    if ( stream == NULL ) {
        printf("Error abriendo fichero para fase 2 de traducción\n");
        exit(-1);
    }
    // execute phase
    if ( translate(stream, PHASE2) != 0 )
        exit(-1);
    // close
    fclose(stream);
    
    // phase 3 of translation
    stream = fopen(PHASE2OUTPUT, "rt");
    if ( stream == NULL ) {
        printf("Error abriendo fichero para fase 3 de traducción\n");
        exit(-1);
    }
    // execute phase
    if ( translate(stream, PHASE3) != 0 )
        exit(-1);
    // close
    fclose(stream);
    
    return 0;
}