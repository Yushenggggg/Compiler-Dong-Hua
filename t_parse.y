%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "t2c.h"
	#include "t2c_tree.h"
	#include "t_parse.h"
%}

%token lWRITE lREAD lIF lASSIGN
%token lRETURN lBEGIN lEND
%token lLP lRP
%token lINT lREAL lSTRING
%token lELSE
%token lMAIN
%token lSEMI lCOMMA
%token lID lINUM lRNUM lQSTR

%left  lEQU lNEQ lGT lLT lGE lLE
%left  lADD lMINUS
%left  lTIMES lDIVIDE

%union { tSTM* sm;
         tEXP* ex;
         int iv;
         float rv;
         char* sr;
       }

%type <sm> prog
%type <sm> mthdcls
%type <sm> mthdcl
%type <sm> block
%type <sm> stmts
%type <sm> stmt
%type <sm> vardcl
%type <sm> astm
%type <sm> rstm
%type <sm> istm
%type <sm> wstm
%type <sm> dstm

%type <ex> type
%type <ex> formals
%type <ex> formal
%type <ex> oformal
%type <ex> expr
%type <ex> mexprs
%type <ex> mexpr
%type <ex> pexprs
%type <ex> pexpr
%type <ex> bexpr
%type <ex> aparams
%type <ex> oparams

%type <sr> lID
%type <iv> lINUM
%type <rv> lRNUM
%type <sr> lQSTR

%expect 1

%%
prog	:	mthdcls
		{ 	$$ = $1;
		  	program = $$; }
	|
		{ 	printf("****** Parsing failed!\n"); }
	;

mthdcls	:	mthdcl mthdcls
		{ 	$$ = $1;
		  	$$->next = $2; }
	|	mthdcl
		{ 	$$ = $1; }
	;

type	:	lINT
		{ 	$$ = create_exp();
			$$->exp_id = eTYPE;
			printf("MyTiny parse: type ok!\n");
			$$->ival = tINT; }
	|	lREAL
		{ 	$$ = create_exp();
			$$->exp_id = eTYPE;
			$$->ival = tREAL; }
	;

mthdcl	:	type lMAIN lID lLP formals lRP block
		{ 	$$ = create_stm();					
			$$->stm_id = sMAIN;
			$$->exp1 = create_exp();
			$$->exp1->exp_id = eID;
			strcpy( $$->exp1->name, $3 );
			$$->exp1->exp1 = $1;
			$$->exp2 = $5;
			$$->stm1 = $7;
			symtab = create_symnode( $3, $1->ival ); }
	|	type lID lLP formals lRP block
		{ 	$$ = create_stm();
			$$->stm_id = sMDCL;
			$$->exp1 = create_exp();
			$$->exp1->exp_id = eID;
			strcpy( $$->exp1->name, $2 );
			$$->exp1->exp1 = $1;
			$$->exp2 = $4;
			$$->stm1 = $6;
			symtab = create_symnode( $2, $1->ival ); }
	;

formals	:	formal oformal
		{ 	$$ = $1;
		  	$$->next = $2; }
	|
		{ 	$$ = NULL; }
	;

formal	:	type lID
		{ 	$$ = create_exp();
			$$->exp_id = eFORM;
			$$->exp1 = $1;
			strcpy( $$->name, $2 );
			symtab = create_symnode( $2, $1->ival ); }
	;

oformal	:	lCOMMA formal oformal
		{ 	$$ = $2;
		  	$$->next = $3; }
	|
		{ 	$$ = NULL; }
	;

block	:	lBEGIN stmts lEND
		{ 	$$ = create_stm();
			$$->stm_id = sBLOCK;
			printf("MyTiny parse: block ok!\n");
			$$->stm1 = $2; }
	;

stmts	:	stmt stmts
		{ 	$$ = $1;
		  	$$->next = $2; }
	|	stmt
		{ 	$$ = $1; }
	;

stmt	:	block
		{ 	$$ = $1; }
	|	vardcl
		{ 	$$ = $1; }
	|	astm
		{ 	$$ = $1; }
	|	rstm
		{ 	$$ = $1; }
	|	istm
		{ 	$$ = $1; }
	|	wstm
		{ 	$$ = $1; }
	|	dstm
		{ 	$$ = $1; }
	;

vardcl	:	type lID lSEMI
		{ // Write your own semantic action here.
			$$ = create_stm();
			$$->stm_id = sVDCL1;
			$$->exp1 = $1;
			strcpy( $$->exp1->name, $2 );
			symtab = create_symnode( $2, $1->ival );
		}
	|	type astm
		{ // Write your own semantic action here.
			$$ = create_stm();
			$$->stm_id = sVDCL2;
			$$->exp1 = $1;
			$$->stm1 = $2;
			symtab = create_symnode( $2->exp1->name, $1->ival );
		}
	;

astm	:	lID lASSIGN expr lSEMI
		{ // Write your own semantic action here.
			$$ = create_stm();
			$$->stm_id = sASTM;
			$$->exp1 = create_exp();
			$$->exp1->exp_id = eASSIGN1;
			strcpy( $$->exp1->name, $1 );
			$$->exp1->exp1 = $3;
		}
	;

rstm	:	lRETURN expr lSEMI
		{ 	$$ = create_stm();
			$$->stm_id = sRSTM;
			$$->exp1 = $2; }
	;

istm	:	lIF lLP bexpr lRP stmt
		{ // Write your own semantic action here.
			$$ = create_stm();
			$$->stm_id = sISTM;
			$$->exp1 = $3;
			$$->stm1 = $5;
		}
	|	lIF lLP bexpr lRP stmt lELSE stmt
		{ 	$$ = create_stm();
			$$->stm_id = sISTM;
			$$->exp1 = $3;
			$$->stm1 = $5;
			$$->stm2 = $7; }
	;

wstm	:	lWRITE lLP expr lCOMMA lQSTR lRP lSEMI
		{ // Write your own semantic action here.
			$$ = create_stm();
			$$->stm_id = sWSTM;
			$$->exp1 = create_exp();
			$$->exp1->exp1 = $3;		//之後要注意
			$$->exp1->exp_id = eWSTM;
			strcpy($$->exp1->qstr, $5 );
		}
	;

dstm	:	lREAD lLP lID lCOMMA lQSTR lRP lSEMI
		{ // Write your own semantic action here.
			$$ = create_stm();
			$$->stm_id = sDSTM;
			$$->exp1 = create_exp();
			strcpy($$->exp1->name, $3 );
			$$->exp1->exp_id = eDSTM;
			strcpy($$->exp1->qstr, $5 );
		}
	;

expr	:	mexpr mexprs
		{ 	$$ = create_exp();
		  	$$->exp_id = eEXPR;
		  	$$->exp1 = $1;
		  	$$->next = $2; }
	;

mexprs	:	lADD mexpr mexprs
		{ 	$$ = create_exp();
			$$->exp_id = eADD;
			$$->exp1 = $2;
			$$->next = $3; }
	|	lMINUS mexpr mexprs
		{ 	$$ = create_exp();
			$$->exp_id = eMINUS;
			$$->exp1 = $2;
			$$->next = $3; }
	|
		{ 	$$ = NULL; }	
	;

mexpr	:	pexpr pexprs
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eMEXP;
			$$->exp1 = $1;
			$$->next = $2;
		}
	;

pexprs	:	lTIMES pexpr pexprs
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eTIMES;
			$$->exp1 = $2;
			$$->next = $3;
		}
	|	lDIVIDE pexpr pexprs
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eDIVIDE;
			$$->exp1 = $2;
			$$->next = $3;
		}
	|
		{ $$ = NULL; }
	;

pexpr	:	lINUM
		{ 	$$ = create_exp();
			$$->exp_id = eINUM;
			$$->ival = $1; }
	|	lRNUM
		{ 	$$ = create_exp();
			$$->exp_id = eRNUM;
			$$->rval = $1; }
	|	lID
		{ 	$$ = create_exp();
			$$->exp_id = eID;
			strcpy( $$->name, $1 ); }
	|	lLP expr lRP
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eEXPR;
			$$->next = $2;
		}
	|	lID lLP aparams lRP
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eFUNC;
			strcpy( $$->name, $1 ); 		
			$$->exp1 = $3;			
		}
	;

bexpr	:	expr lEQU expr
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eEQ;
			$$->exp1 = $1;
			$$->next = $3;
		}
	|	expr lNEQ expr
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eNE;
			$$->exp1 = $1;
			$$->next = $3;
		}
	|	expr lGT expr
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eGT;
			$$->exp1 = $1;
			$$->next = $3;
		}
	|	expr lLT expr
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eLT;
			$$->exp1 = $1;
			$$->next = $3;
		}
	|	expr lGE expr
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eGE;
			$$->exp1 = $1;
			$$->next = $3;
		}
	|	expr lLE expr
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eLE;
			$$->exp1 = $1;
			$$->next = $3;
		}
	;

aparams	:	expr oparams
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eAPARM;
			$$->exp1  = $1;
			$$->next  = $2;
		}
	|
		{ // Write your own semantic action here.
			$$ = NULL; 
		}
	;

oparams	:	lCOMMA expr oparams
		{ // Write your own semantic action here.
			$$ = create_exp();
			$$->exp_id = eEXPR;
			$$->exp1  = $2;
			$$->next  = $3;
			/*$$ = $2;
			$$ -> next = $3;*/
		}
	|
		{ // Write your own semantic action here.
			$$ = NULL; 
		}
	;



%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return 1;
}

