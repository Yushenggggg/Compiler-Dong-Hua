
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     lWRITE = 258,
     lREAD = 259,
     lIF = 260,
     lASSIGN = 261,
     lRETURN = 262,
     lBEGIN = 263,
     lEND = 264,
     lLP = 265,
     lRP = 266,
     lINT = 267,
     lREAL = 268,
     lSTRING = 269,
     lELSE = 270,
     lMAIN = 271,
     lSEMI = 272,
     lCOMMA = 273,
     lID = 274,
     lINUM = 275,
     lRNUM = 276,
     lQSTR = 277,
     lLE = 278,
     lGE = 279,
     lLT = 280,
     lGT = 281,
     lNEQ = 282,
     lEQU = 283,
     lMINUS = 284,
     lADD = 285,
     lDIVIDE = 286,
     lTIMES = 287
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 23 "t_parse.y"
 tSTM* sm;
         tEXP* ex;
         int iv;
         float rv;
         char* sr;
       


/* Line 1676 of yacc.c  */
#line 93 "t_parse.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


