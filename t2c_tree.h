
extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern FILE *yyout;
extern FILE *yyerr;

extern char name[16];
extern int ival;
extern float rval;
extern char qstr[80];

// The following are for parse trees.

#define sMIN 0
#define sMAIN 1
#define sMDCL 2
#define sBLOCK 3
#define sVDCL1 4
#define sVDCL2 5
#define sASTM 6
#define sRSTM 7
#define sISTM 8
#define sWSTM 9
#define sDSTM 10
#define sMAX 11

#define eMIN 0
#define eTYPE 1
#define eFORM 2
#define eEXPR 3
#define eADD 4
#define eMINUS 5
#define eMEXP 6
#define eTIMES 7
#define eDIVIDE 8
#define eINUM 9
#define eRNUM 10
#define eID 11
#define ePAREN 12
#define eFUNC 13
#define eEQ 14
#define eNE 15
#define eGT 16
#define eLT 17
#define eGE 18
#define eLE 19
#define eAPARM 20
#define eASSIGN1 21
#define eASSIGN2 22
#define eWSTM 23
#define eDSTM 24
#define eMAX 25

#define tMIN 0
#define tINT 1
#define tREAL 2
#define tSTRING 3
#define tMAX 4

typedef struct t_exp {
  int exp_id;
  char name[16];
  int  ival;
  float rval;
  char qstr[80];
  struct t_exp *exp1;
  struct t_exp *next;
} tEXP;

typedef struct t_stm {
  int stm_id;
  struct t_exp *exp1;
  struct t_exp *exp2;
  struct t_stm *stm1;
  struct t_stm *stm2;
  struct t_stm *next;
} tSTM;

typedef struct sym_node {
  char name[16];
  int type;
  struct sym_node *next;
} symNODE;

extern tEXP* create_exp();
extern tSTM* create_stm();
extern symNODE* create_symnode( char*, int );
extern void free_exp( tEXP* );
extern void free_stm( tSTM* );
extern void free_symnode( symNODE* );
extern void print_exp( tEXP* );
extern void gen_exp( tEXP* );
extern void print_stm( tSTM* );
extern void gen_code( tSTM* );
extern int lookup( symNODE*, char* );
extern void init_all();
extern void gen_rwcode();
extern int ana_exptype( tEXP* );

extern tSTM* program;
extern char name[16];
extern int ival;
extern float rval;
extern char qstr[80];
extern int gen_rw[2][3];
extern symNODE *symtab;

