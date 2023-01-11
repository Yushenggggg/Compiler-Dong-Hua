#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "t2c.h"
#include "t2c_tree.h"
#include "t_parse.h"

char name[16];
int ival;
float rval;
char qstr[80];
tSTM *program;
int gen_rw[2][3];
symNODE *symtab = NULL;

int main(int argc,char *argv[]) {
    int a = argc;
    int t, i;
    char fname[20];

    if (a == 2) {
        yyin = fopen(argv[1],"r");
	if (yyin) {
	    init_all();
	    t = yyparse();
	    if (t) {
		// Parsing fails
		printf("mytiny2c: Parsing failed!\n");
	    } else {
		// Parsing succeeds
		printf("mytiny2c: Parsing succeeded!\n");
		strcpy( fname, argv[1] );
		for (i=0; (fname[i]!='.') && (fname[i]!='\0'); i++);
		fname[i++] = '.';
		fname[i++] = 'c';
		fname[i] = '\0';
		yyout = fopen( fname, "w" );
		gen_rwcode();
		printf("mytiny2c: starting gen_code!\n");
		gen_code( program );
		fclose( yyout );
	    }
	} else {
	    printf("tiny2c syntax: [tiny2c source_file_name]\n");
	}
	fclose( yyin );
    } else {
	printf("tiny2c syntax: [tiny2c source_file_name]\n");
    }
}
