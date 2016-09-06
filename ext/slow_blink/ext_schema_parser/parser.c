/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Skeleton implementation for Bison GLR parsers in C

   Copyright (C) 2002-2013 Free Software Foundation, Inc.

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

/* C GLR parser skeleton written by Paul Hilfinger.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "glr.c"

/* Pure parsers.  */
#define YYPURE 1






/* First part of user declarations.  */
#line 6 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:207  */


/* includes ***********************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ruby.h>
#include <assert.h>

#include "lexer.h"

/* function prototypes ************************************************/

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg, ... );

/* static function prototypes *****************************************/

static VALUE parseFileBuffer(int argc, VALUE* argv, VALUE self);
static VALUE newLocation(VALUE filename, const YYLTYPE *location);

/* static variables ***************************************************/

static VALUE cSlowBlink;

static VALUE cNameWithID;

static VALUE cNamespace;
static VALUE cGroup;
static VALUE cField;
static VALUE cAnnotation;
static VALUE cIncrementalAnnotation;

static VALUE cDefinition;
static VALUE cENUMERATION;
static VALUE cSym;

static VALUE cI8;
static VALUE cI16;
static VALUE cI32;
static VALUE cI64;
static VALUE cU8;
static VALUE cU16;
static VALUE cU32;
static VALUE cU64;
static VALUE cFLOATING_POINT;
static VALUE cDECIMAL;
static VALUE cFIXED;
static VALUE cSEQUENCE;
static VALUE cSTRING;
static VALUE cBOOLEAN;
static VALUE cOBJECT;
static VALUE cBINARY;
static VALUE cREF;

static VALUE cDATE;
static VALUE cTIME_OF_DAY_MILLI;
static VALUE cTIME_OF_DAY_NANO;
static VALUE cMILLI_TIME;
static VALUE cNANO_TIME;

static VALUE cSchemaRef;
static VALUE cDefinitionRef;
static VALUE cDefinitionTypeRef;
static VALUE cFieldRef;
static VALUE cFieldTypeRef;

static VALUE cLog;

/* generated **********************************************************/


#line 127 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:207  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

#include "parser.h"

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Default (constant) value used for initialization for null
   right-hand sides.  Unlike the standard yacc.c template, here we set
   the default value of $$ to a zeroed-out value.  Since the default
   value is undefined, this behavior is technically correct.  */
static YYSTYPE yyval_default;
static YYLTYPE yyloc_default
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;

/* Copy the second part of user declarations.  */

#line 160 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:230  */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YYFREE
# define YYFREE free
#endif
#ifndef YYMALLOC
# define YYMALLOC malloc
#endif
#ifndef YYREALLOC
# define YYREALLOC realloc
#endif

#define YYSIZEMAX ((size_t) -1)

#ifdef __cplusplus
   typedef bool yybool;
#else
   typedef unsigned char yybool;
#endif
#define yytrue 1
#define yyfalse 0

#ifndef YYSETJMP
# include <setjmp.h>
# define YYJMP_BUF jmp_buf
# define YYSETJMP(Env) setjmp (Env)
/* Pacify clang.  */
# define YYLONGJMP(Env, Val) (longjmp (Env, Val), YYASSERT (0))
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#ifndef YYASSERT
# define YYASSERT(Condition) ((void) ((Condition) || (abort (), 0)))
#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  49
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   198

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  50
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  46
/* YYNRULES -- Number of rules.  */
#define YYNRULES  125
/* YYNRULES -- Number of states.  */
#define YYNSTATES  158
/* YYMAXRHS -- Maximum number of symbols on right-hand side of rule.  */
#define YYMAXRHS 5
/* YYMAXLEFT -- Maximum number of symbols to the left of a handle
   accessed by $0, $-1, etc., in any rule.  */
#define YYMAXLEFT 0

/* YYTRANSLATE(X) -- Bison symbol number corresponding to X.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   291

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const unsigned char yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      43,    44,    45,     2,    39,     2,    49,    47,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    38,     2,
       2,    37,     2,    40,    48,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    41,     2,    42,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    46,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36
};

#if YYDEBUG
/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short int yyrline[] =
{
       0,   129,   129,   136,   142,   150,   155,   159,   165,   172,
     178,   184,   188,   195,   203,   209,   217,   225,   233,   239,
     246,   257,   262,   269,   271,   275,   277,   279,   281,   283,
     285,   287,   293,   301,   309,   315,   323,   329,   337,   345,
     350,   357,   363,   371,   377,   383,   389,   395,   401,   407,
     413,   419,   425,   433,   439,   445,   451,   457,   466,   472,
     479,   485,   492,   501,   503,   508,   515,   520,   524,   530,
     536,   544,   546,   553,   561,   563,   568,   575,   583,   588,
     594,   600,   606,   614,   620,   627,   629,   631,   633,   637,
     639,   643,   645,   649,   654,   659,   664,   669,   674,   679,
     684,   689,   694,   699,   704,   709,   714,   719,   724,   729,
     734,   739,   744,   749,   754,   759,   766,   770,   772,   776,
     783,   787,   789,   793,   797,   801
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "\"i8\"", "\"i16\"", "\"i32\"",
  "\"i64\"", "\"u8\"", "\"u16\"", "\"u32\"", "\"u64\"", "\"f64\"",
  "\"decimal\"", "\"date\"", "\"timeOfDayMilli\"", "\"timeOfDayNano\"",
  "\"nanotime\"", "\"millitime\"", "\"boolean\"", "\"string\"",
  "\"object\"", "\"namespace\"", "\"type\"", "\"schema\"", "\"binary\"",
  "\"number\"", "\"fixed\"", "\"<-\"", "\"->\"", "\"hexnum\"", "\"uint\"",
  "\"int\"", "\"name\"", "\"ncName\"", "\"\\\\ncName\"", "\"cName\"",
  "\"\\\"<annotation>\\\" or '<annotation>'\"", "'='", "':'", "','", "'?'",
  "'['", "']'", "'('", "')'", "'*'", "'|'", "'/'", "'@'", "'.'", "$accept",
  "top", "namespace", "defs", "defList", "def", "define", "groupDef",
  "fields", "field", "opt", "type", "single", "sequence", "string",
  "binary", "fixed", "size", "ref", "number", "time", "enum", "symList",
  "sym", "val", "annots", "annotList", "annot", "literal", "nameWithId",
  "id", "incrAnnot", "compRef", "incrAnnotList", "incrAnnotItem", "qName",
  "qNameOrKeyword", "keyword", "cName", "name", "nsDecl", "literalSegment",
  "int", "uInt", "hexNum", "e", YY_NULLPTR
};
#endif

#define YYPACT_NINF -89
#define YYTABLE_NINF -62

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const short int yypact[] =
{
      79,   -18,   -89,   -89,   -89,   -89,    18,    48,   -89,   -89,
      84,   -89,   -18,   -29,   -89,   -89,    23,     5,   -89,   -89,
     150,    64,   -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89,
     -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89,
     -89,   -89,   -89,   -89,   -89,   -89,   -89,    33,   -89,   -89,
     -89,   -89,   -89,   -89,    19,    24,   -89,    67,    45,   -16,
     -89,    37,   -29,    75,   -26,    32,   -89,   -89,   -89,   -89,
     -89,   -89,   -89,    67,   -89,    26,   -89,    37,   -89,    65,
     -89,   146,   -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89,
     -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89,    60,   -89,
      60,    60,   -29,   -89,    70,   -89,   -89,   -89,   -89,   -89,
     -89,   -89,   -89,    59,   -89,   -18,    61,    92,   -89,   -89,
     -89,   -89,   -89,   100,   -89,   -29,   -29,    32,   -89,   -89,
     -89,   -89,    82,   -29,    78,   -89,   -29,   -89,   -89,   -18,
      85,    86,   -89,    80,   -19,   -89,   -89,    65,    88,   -89,
     -89,   -89,   -89,   -89,   -89,   -89,   -89,   -89
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const unsigned char yydefact[] =
{
     125,     0,    78,   117,   118,   116,     0,     0,     2,     3,
       6,     7,     0,    67,    68,    11,     0,    79,    90,    89,
     125,    66,   119,    93,    94,    95,    96,    97,    98,    99,
     100,   101,   102,   103,   104,   105,   106,   107,   108,   109,
     112,   113,   114,   115,   110,   111,    91,     0,    92,     1,
       8,    66,     9,    10,    14,   125,    69,     0,    77,     0,
       4,     0,   125,     0,     0,     0,    73,    74,    87,    86,
      85,    88,    83,     0,    80,    81,   120,    70,    71,    17,
      18,     0,    43,    44,    45,    46,    47,    48,    49,    50,
      51,    52,    53,    54,    55,    56,    57,    31,    34,    32,
      36,     0,   125,    13,    23,    24,    28,    29,    30,    25,
      27,    26,    12,     0,    60,     0,    41,    15,   124,   123,
      75,    76,    84,     0,    72,   125,   125,     0,    35,    37,
      38,    58,     0,   125,   125,    42,   125,    82,    19,     0,
       0,     0,    33,    59,     0,    62,    63,    16,   125,    39,
      40,   122,   121,    64,    65,    22,    20,    21
};

  /* YYPGOTO[NTERM-NUM].  */
static const signed char yypgoto[] =
{
     -89,   -89,   -89,   111,   -89,   123,   -89,   -89,    -1,    11,
     -89,    56,   -89,   -89,   -89,   -89,   -89,   -32,   -89,   -89,
     -89,   -89,   -89,   -88,   -89,   -59,   -89,    -8,   -89,     2,
     -89,   -89,   -89,   -89,    66,    -5,   -89,   -89,   -89,     1,
     -89,    68,   -89,    15,   -81,     0
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const short int yydefgoto[] =
{
      -1,     7,     8,     9,    10,    11,    52,    53,    79,    80,
     156,   103,   104,   105,   106,   107,   108,   128,   109,   110,
     111,   112,   113,   114,   145,    12,    13,    14,    77,    54,
      66,    15,    16,    58,    72,    17,    47,    48,    18,    19,
      20,    78,   153,   120,   121,    51
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const short int yytable[] =
{
      21,    46,    22,    81,   115,    56,    74,     3,     4,     5,
     118,   151,   152,    55,   131,     3,     4,     3,     4,     6,
      21,    23,    24,    25,    26,    27,    28,    29,    30,    31,
      32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
      42,    43,    44,   115,    45,   143,   141,    62,    49,    71,
      57,     3,     4,     5,    59,    67,    63,    64,   116,   117,
      75,   118,   119,   154,    -5,    71,    81,   139,   129,   130,
      61,    65,    73,    76,   115,   123,   116,    81,    82,    83,
      84,    85,    86,    87,    88,    89,    90,    91,    92,    93,
      94,    95,    96,    97,    98,    99,    68,    69,    70,   100,
       1,   101,     2,   127,   125,   133,   135,     2,     3,     4,
       5,   132,     3,     4,     5,     6,   134,     3,     4,     5,
     136,   102,   137,     6,   142,   144,   -61,     6,   155,   149,
     150,    60,     6,    50,   146,   147,   138,   126,     0,   122,
      55,   148,   140,     0,     0,   124,     0,     0,   157,    82,
      83,    84,    85,    86,    87,    88,    89,    90,    91,    92,
      93,    94,    95,    96,    97,    98,    99,     0,     0,     0,
     100,     0,   101,     2,     0,     0,     0,     0,     0,     3,
       4,     5,     0,     3,     4,     5,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     6
};

static const short int yycheck[] =
{
       0,     6,     1,    62,    63,    13,    22,    33,    34,    35,
      29,    30,    31,    12,   102,    33,    34,    33,    34,    48,
      20,     3,     4,     5,     6,     7,     8,     9,    10,    11,
      12,    13,    14,    15,    16,    17,    18,    19,    20,    21,
      22,    23,    24,   102,    26,   133,   127,    28,     0,    57,
      27,    33,    34,    35,    49,    55,    37,    38,    63,    64,
      59,    29,    30,   144,     0,    73,   125,   126,   100,   101,
      37,    47,    27,    36,   133,    49,    81,   136,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    29,    30,    31,    24,
      21,    26,    23,    43,    39,    46,    45,    23,    33,    34,
      35,    41,    33,    34,    35,    48,   115,    33,    34,    35,
      28,    46,    22,    48,    42,    47,    46,    48,    40,    44,
      44,    20,    48,    10,   134,   136,   125,    81,    -1,    73,
     139,   139,   127,    -1,    -1,    77,    -1,    -1,   148,     3,
       4,     5,     6,     7,     8,     9,    10,    11,    12,    13,
      14,    15,    16,    17,    18,    19,    20,    -1,    -1,    -1,
      24,    -1,    26,    23,    -1,    -1,    -1,    -1,    -1,    33,
      34,    35,    -1,    33,    34,    35,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    48
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,    21,    23,    33,    34,    35,    48,    51,    52,    53,
      54,    55,    75,    76,    77,    81,    82,    85,    88,    89,
      90,    95,    89,     3,     4,     5,     6,     7,     8,     9,
      10,    11,    12,    13,    14,    15,    16,    17,    18,    19,
      20,    21,    22,    23,    24,    26,    85,    86,    87,     0,
      55,    95,    56,    57,    79,    89,    77,    27,    83,    49,
      53,    37,    28,    37,    38,    47,    80,    95,    29,    30,
      31,    77,    84,    27,    22,    89,    36,    78,    91,    58,
      59,    75,     3,     4,     5,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
      24,    26,    46,    61,    62,    63,    64,    65,    66,    68,
      69,    70,    71,    72,    73,    75,    85,    85,    29,    30,
      93,    94,    84,    49,    91,    39,    61,    43,    67,    67,
      67,    73,    41,    46,    89,    45,    28,    22,    59,    75,
      93,    94,    42,    73,    47,    74,    95,    58,    79,    44,
      44,    30,    31,    92,    94,    40,    60,    95
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    50,    51,    52,    52,    53,    53,    54,    54,    55,
      55,    55,    56,    56,    57,    57,    57,    57,    58,    58,
      59,    60,    60,    61,    61,    62,    62,    62,    62,    62,
      62,    62,    62,    63,    64,    64,    65,    65,    66,    67,
      67,    68,    68,    69,    69,    69,    69,    69,    69,    69,
      69,    69,    69,    70,    70,    70,    70,    70,    71,    71,
      72,    72,    73,    74,    74,    74,    75,    75,    76,    76,
      77,    78,    78,    79,    80,    80,    80,    81,    82,    82,
      82,    82,    82,    83,    83,    84,    84,    84,    84,    85,
      85,    86,    86,    87,    87,    87,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    87,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    87,    88,    89,    89,    90,
      91,    92,    92,    93,    94,    95
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     1,     1,     2,     1,     1,     1,     2,     2,
       2,     1,     3,     3,     1,     3,     5,     3,     1,     3,
       5,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     3,     1,     2,     1,     2,     2,     3,
       3,     1,     2,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     2,     3,
       1,     3,     3,     1,     2,     2,     1,     1,     1,     2,
       4,     1,     2,     2,     1,     2,     2,     2,     1,     1,
       3,     3,     5,     2,     3,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     2,
       1,     1,     1,     1,     1,     0
};


/* YYDPREC[RULE-NUM] -- Dynamic precedence of rule #RULE-NUM (0 if none).  */
static const unsigned char yydprec[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0
};

/* YYMERGER[RULE-NUM] -- Index of merging function for rule #RULE-NUM.  */
static const unsigned char yymerger[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0
};

/* YYIMMEDIATE[RULE-NUM] -- True iff rule #RULE-NUM is not to be deferred, as
   in the case of predicates.  */
static const yybool yyimmediate[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0
};

/* YYCONFLP[YYPACT[STATE-NUM]] -- Pointer into YYCONFL of start of
   list of conflicting reductions corresponding to action entry for
   state STATE-NUM in yytable.  0 means no conflicts.  The list in
   yyconfl is terminated by a rule number of 0.  */
static const unsigned char yyconflp[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    13,    15,
       0,     0,     1,     3,     0,     0,     0,     5,     7,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     9,    11,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0
};

/* YYCONFL[I] -- lists of conflicting rule numbers, each terminated by
   0, pointed into by YYCONFLP.  */
static const short int yyconfl[] =
{
       0,   125,     0,   125,     0,   125,     0,   125,     0,   125,
       0,   125,     0,   125,     0,   125,     0
};

/* Error token number */
#define YYTERROR 1


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

# define YYRHSLOC(Rhs, K) ((Rhs)[K].yystate.yyloc)



#undef yynerrs
#define yynerrs (yystackp->yyerrcnt)
#undef yychar
#define yychar (yystackp->yyrawchar)
#undef yylval
#define yylval (yystackp->yyval)
#undef yylloc
#define yylloc (yystackp->yyloc)


static const int YYEOF = 0;
static const int YYEMPTY = -2;

typedef enum { yyok, yyaccept, yyabort, yyerr } YYRESULTTAG;

#define YYCHK(YYE)                              \
  do {                                          \
    YYRESULTTAG yychk_flag = YYE;               \
    if (yychk_flag != yyok)                     \
      return yychk_flag;                        \
  } while (0)

#if YYDEBUG

# ifndef YYFPRINTF
#  define YYFPRINTF fprintf
# endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static unsigned
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  unsigned res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


# define YYDPRINTF(Args)                        \
  do {                                          \
    if (yydebug)                                \
      YYFPRINTF Args;                           \
  } while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  YYUSE (yylocationp);
  YYUSE (scanner);
  YYUSE (filename);
  YYUSE (tree);
  if (!yyvaluep)
    return;
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp, scanner, filename, tree);
  YYFPRINTF (yyoutput, ")");
}

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                  \
  do {                                                                  \
    if (yydebug)                                                        \
      {                                                                 \
        YYFPRINTF (stderr, "%s ", Title);                               \
        yy_symbol_print (stderr, Type, Value, Location, scanner, filename, tree);        \
        YYFPRINTF (stderr, "\n");                                       \
      }                                                                 \
  } while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;

struct yyGLRStack;
static void yypstack (struct yyGLRStack* yystackp, size_t yyk)
  YY_ATTRIBUTE_UNUSED;
static void yypdumpstack (struct yyGLRStack* yystackp)
  YY_ATTRIBUTE_UNUSED;

#else /* !YYDEBUG */

# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)

#endif /* !YYDEBUG */

/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   SIZE_MAX < YYMAXDEPTH * sizeof (GLRStackItem)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif

/* Minimum number of free items on the stack allowed after an
   allocation.  This is to allow allocation and initialization
   to be completed by functions that call yyexpandGLRStack before the
   stack is expanded, thus insuring that all necessary pointers get
   properly redirected to new data.  */
#define YYHEADROOM 2

#ifndef YYSTACKEXPANDABLE
#  define YYSTACKEXPANDABLE 1
#endif

#if YYSTACKEXPANDABLE
# define YY_RESERVE_GLRSTACK(Yystack)                   \
  do {                                                  \
    if (Yystack->yyspaceLeft < YYHEADROOM)              \
      yyexpandGLRStack (Yystack);                       \
  } while (0)
#else
# define YY_RESERVE_GLRSTACK(Yystack)                   \
  do {                                                  \
    if (Yystack->yyspaceLeft < YYHEADROOM)              \
      yyMemoryExhausted (Yystack);                      \
  } while (0)
#endif


#if YYERROR_VERBOSE

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static size_t
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      size_t yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return strlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

#endif /* !YYERROR_VERBOSE */

/** State numbers, as in LALR(1) machine */
typedef int yyStateNum;

/** Rule numbers, as in LALR(1) machine */
typedef int yyRuleNum;

/** Grammar symbol */
typedef int yySymbol;

/** Item references, as in LALR(1) machine */
typedef short int yyItemNum;

typedef struct yyGLRState yyGLRState;
typedef struct yyGLRStateSet yyGLRStateSet;
typedef struct yySemanticOption yySemanticOption;
typedef union yyGLRStackItem yyGLRStackItem;
typedef struct yyGLRStack yyGLRStack;

struct yyGLRState {
  /** Type tag: always true.  */
  yybool yyisState;
  /** Type tag for yysemantics.  If true, yysval applies, otherwise
   *  yyfirstVal applies.  */
  yybool yyresolved;
  /** Number of corresponding LALR(1) machine state.  */
  yyStateNum yylrState;
  /** Preceding state in this stack */
  yyGLRState* yypred;
  /** Source position of the last token produced by my symbol */
  size_t yyposn;
  union {
    /** First in a chain of alternative reductions producing the
     *  non-terminal corresponding to this state, threaded through
     *  yynext.  */
    yySemanticOption* yyfirstVal;
    /** Semantic value for this state.  */
    YYSTYPE yysval;
  } yysemantics;
  /** Source location for this state.  */
  YYLTYPE yyloc;
};

struct yyGLRStateSet {
  yyGLRState** yystates;
  /** During nondeterministic operation, yylookaheadNeeds tracks which
   *  stacks have actually needed the current lookahead.  During deterministic
   *  operation, yylookaheadNeeds[0] is not maintained since it would merely
   *  duplicate yychar != YYEMPTY.  */
  yybool* yylookaheadNeeds;
  size_t yysize, yycapacity;
};

struct yySemanticOption {
  /** Type tag: always false.  */
  yybool yyisState;
  /** Rule number for this reduction */
  yyRuleNum yyrule;
  /** The last RHS state in the list of states to be reduced.  */
  yyGLRState* yystate;
  /** The lookahead for this reduction.  */
  int yyrawchar;
  YYSTYPE yyval;
  YYLTYPE yyloc;
  /** Next sibling in chain of options.  To facilitate merging,
   *  options are chained in decreasing order by address.  */
  yySemanticOption* yynext;
};

/** Type of the items in the GLR stack.  The yyisState field
 *  indicates which item of the union is valid.  */
union yyGLRStackItem {
  yyGLRState yystate;
  yySemanticOption yyoption;
};

struct yyGLRStack {
  int yyerrState;
  /* To compute the location of the error token.  */
  yyGLRStackItem yyerror_range[3];

  int yyerrcnt;
  int yyrawchar;
  YYSTYPE yyval;
  YYLTYPE yyloc;

  YYJMP_BUF yyexception_buffer;
  yyGLRStackItem* yyitems;
  yyGLRStackItem* yynextFree;
  size_t yyspaceLeft;
  yyGLRState* yysplitPoint;
  yyGLRState* yylastDeleted;
  yyGLRStateSet yytops;
};

#if YYSTACKEXPANDABLE
static void yyexpandGLRStack (yyGLRStack* yystackp);
#endif

static _Noreturn void
yyFail (yyGLRStack* yystackp, YYLTYPE *yylocp, yyscan_t scanner, VALUE filename, VALUE *tree, const char* yymsg)
{
  if (yymsg != YY_NULLPTR)
    yyerror (yylocp, scanner, filename, tree, yymsg);
  YYLONGJMP (yystackp->yyexception_buffer, 1);
}

static _Noreturn void
yyMemoryExhausted (yyGLRStack* yystackp)
{
  YYLONGJMP (yystackp->yyexception_buffer, 2);
}

#if YYDEBUG || YYERROR_VERBOSE
/** A printable representation of TOKEN.  */
static inline const char*
yytokenName (yySymbol yytoken)
{
  if (yytoken == YYEMPTY)
    return "";

  return yytname[yytoken];
}
#endif

/** Fill in YYVSP[YYLOW1 .. YYLOW0-1] from the chain of states starting
 *  at YYVSP[YYLOW0].yystate.yypred.  Leaves YYVSP[YYLOW1].yystate.yypred
 *  containing the pointer to the next state in the chain.  */
static void yyfillin (yyGLRStackItem *, int, int) YY_ATTRIBUTE_UNUSED;
static void
yyfillin (yyGLRStackItem *yyvsp, int yylow0, int yylow1)
{
  int i;
  yyGLRState *s = yyvsp[yylow0].yystate.yypred;
  for (i = yylow0-1; i >= yylow1; i -= 1)
    {
#if YYDEBUG
      yyvsp[i].yystate.yylrState = s->yylrState;
#endif
      yyvsp[i].yystate.yyresolved = s->yyresolved;
      if (s->yyresolved)
        yyvsp[i].yystate.yysemantics.yysval = s->yysemantics.yysval;
      else
        /* The effect of using yysval or yyloc (in an immediate rule) is
         * undefined.  */
        yyvsp[i].yystate.yysemantics.yyfirstVal = YY_NULLPTR;
      yyvsp[i].yystate.yyloc = s->yyloc;
      s = yyvsp[i].yystate.yypred = s->yypred;
    }
}

/* Do nothing if YYNORMAL or if *YYLOW <= YYLOW1.  Otherwise, fill in
 * YYVSP[YYLOW1 .. *YYLOW-1] as in yyfillin and set *YYLOW = YYLOW1.
 * For convenience, always return YYLOW1.  */
static inline int yyfill (yyGLRStackItem *, int *, int, yybool)
     YY_ATTRIBUTE_UNUSED;
static inline int
yyfill (yyGLRStackItem *yyvsp, int *yylow, int yylow1, yybool yynormal)
{
  if (!yynormal && yylow1 < *yylow)
    {
      yyfillin (yyvsp, *yylow, yylow1);
      *yylow = yylow1;
    }
  return yylow1;
}

/** Perform user action for rule number YYN, with RHS length YYRHSLEN,
 *  and top stack item YYVSP.  YYLVALP points to place to put semantic
 *  value ($$), and yylocp points to place for location information
 *  (@$).  Returns yyok for normal return, yyaccept for YYACCEPT,
 *  yyerr for YYERROR, yyabort for YYABORT.  */
static YYRESULTTAG
yyuserAction (yyRuleNum yyn, size_t yyrhslen, yyGLRStackItem* yyvsp,
              yyGLRStack* yystackp,
              YYSTYPE* yyvalp, YYLTYPE *yylocp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  yybool yynormal YY_ATTRIBUTE_UNUSED = (yystackp->yysplitPoint == YY_NULLPTR);
  int yylow;
  YYUSE (yyvalp);
  YYUSE (yylocp);
  YYUSE (scanner);
  YYUSE (filename);
  YYUSE (tree);
  YYUSE (yyrhslen);
# undef yyerrok
# define yyerrok (yystackp->yyerrState = 0)
# undef YYACCEPT
# define YYACCEPT return yyaccept
# undef YYABORT
# define YYABORT return yyabort
# undef YYERROR
# define YYERROR return yyerrok, yyerr
# undef YYRECOVERING
# define YYRECOVERING() (yystackp->yyerrState != 0)
# undef yyclearin
# define yyclearin (yychar = YYEMPTY)
# undef YYFILL
# define YYFILL(N) yyfill (yyvsp, &yylow, N, yynormal)
# undef YYBACKUP
# define YYBACKUP(Token, Value)                                              \
  return yyerror (yylocp, scanner, filename, tree, YY_("syntax error: cannot back up")),     \
         yyerrok, yyerr

  yylow = 1;
  if (yyrhslen == 0)
    *yyvalp = yyval_default;
  else
    *yyvalp = yyvsp[YYFILL (1-yyrhslen)].yystate.yysemantics.yysval;
  YYLLOC_DEFAULT ((*yylocp), (yyvsp - yyrhslen), yyrhslen);
  yystackp->yyerror_range[1].yystate.yyloc = *yylocp;

  switch (yyn)
    {
        case 2:
#line 130 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        *tree = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1144 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 3:
#line 137 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {filename, Qnil, (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cNamespace);            
    }
#line 1153 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 4:
#line 143 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {filename, (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cNamespace);            
    }
#line 1162 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 5:
#line 151 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
    }
#line 1170 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 7:
#line 160 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1179 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 8:
#line 166 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1187 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 9:
#line 173 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
        rb_funcall(((*yyvalp)), rb_intern("annote"), 1, (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
    }
#line 1196 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 10:
#line 179 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
        rb_funcall(((*yyvalp)), rb_intern("annote"), 1, (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
    }
#line 1205 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 12:
#line 189 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE enumArgs[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)};        
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), rb_class_new_instance(sizeof(enumArgs)/sizeof(*enumArgs),enumArgs, cENUMERATION), newLocation(filename, &(*yylocp))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinition);        
    }
#line 1215 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 13:
#line 196 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cDefinition);        
    }
#line 1224 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 14:
#line 204 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), Qnil, rb_ary_new(), newLocation(filename, &(*yylocp))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
#line 1233 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 15:
#line 210 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE refArgs[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), Qfalse, newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yyloc))};
        VALUE ref = rb_class_new_instance(sizeof(refArgs)/sizeof(*refArgs),refArgs, cREF);
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), ref, rb_ary_new(), newLocation(filename, &(*yylocp))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
#line 1244 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 16:
#line 218 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE refArgs[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), Qfalse, newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yyloc))};
        VALUE ref = rb_class_new_instance(sizeof(refArgs)/sizeof(*refArgs),refArgs, cREF);
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-4)].yystate.yysemantics.yysval), ref, (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
#line 1255 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 17:
#line 226 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), Qnil, (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cGroup);
    }
#line 1264 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 18:
#line 234 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));        
    }
#line 1273 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 19:
#line 240 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1281 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 20:
#line 247 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (-3)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (-3)].yystate.yyloc))};        
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);

        rb_funcall(((*yyvalp)), rb_intern("annote"), 1, (((yyGLRStackItem const *)yyvsp)[YYFILL (-4)].yystate.yysemantics.yysval));
        rb_funcall((((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), rb_intern("annote"), 1, (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
    }
#line 1293 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 21:
#line 258 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = Qfalse;
    }
#line 1301 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 22:
#line 263 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = Qtrue;
    }
#line 1309 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 31:
#line 288 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBOOLEAN);
    }
#line 1318 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 32:
#line 294 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cOBJECT);
    }
#line 1327 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 33:
#line 302 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yyloc))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSEQUENCE);
    }
#line 1336 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 34:
#line 310 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {Qnil, newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSTRING);
    }
#line 1345 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 35:
#line 316 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSTRING);
    }
#line 1354 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 36:
#line 324 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {Qnil, newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBINARY);
    }
#line 1363 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 37:
#line 330 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBINARY);
    }
#line 1372 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 38:
#line 338 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFIXED);
    }
#line 1381 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 39:
#line 346 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval);
    }
#line 1389 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 40:
#line 351 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval);
    }
#line 1397 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 41:
#line 358 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), Qfalse, newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
#line 1406 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 42:
#line 364 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), Qtrue, newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
#line 1415 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 43:
#line 372 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI8);
    }
#line 1424 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 44:
#line 378 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI16);
    }
#line 1433 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 45:
#line 384 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI32);
    }
#line 1442 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 46:
#line 390 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI64);
    }
#line 1451 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 47:
#line 396 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU8);
    }
#line 1460 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 48:
#line 402 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU16);
    }
#line 1469 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 49:
#line 408 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU32);
    }
#line 1478 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 50:
#line 414 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU64);
    }
#line 1487 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 51:
#line 420 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFLOATING_POINT);
    }
#line 1496 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 52:
#line 426 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDECIMAL);
    }
#line 1505 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 53:
#line 434 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDATE);
    }
#line 1514 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 54:
#line 440 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cTIME_OF_DAY_MILLI);
    }
#line 1523 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 55:
#line 446 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cTIME_OF_DAY_NANO);
    }
#line 1532 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 56:
#line 452 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cNANO_TIME);
    }
#line 1541 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 57:
#line 458 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cMILLI_TIME);
    }
#line 1550 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 58:
#line 467 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1559 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 59:
#line 473 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1567 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 60:
#line 480 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1576 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 61:
#line 486 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1584 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 62:
#line 493 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yyloc))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSym);
        rb_funcall(((*yyvalp)), rb_intern("annote"), 1, (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));        
    }
#line 1594 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 64:
#line 504 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1602 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 65:
#line 509 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1610 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 66:
#line 516 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
    }
#line 1618 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 68:
#line 525 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));        
    }
#line 1627 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 69:
#line 531 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1635 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 70:
#line 537 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yyloc))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cAnnotation);
    }
#line 1644 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 72:
#line 547 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_str_append(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1652 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 73:
#line 554 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cNameWithID);
    }
#line 1661 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 75:
#line 564 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1669 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 76:
#line 569 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1677 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 77:
#line 576 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval), newLocation(filename, &(*yylocp))};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cIncrementalAnnotation);
    }
#line 1686 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 78:
#line 584 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_class_new_instance(0, NULL, cSchemaRef);        
    }
#line 1694 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 79:
#line 589 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinitionRef);        
    }
#line 1703 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 80:
#line 595 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval)};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinitionTypeRef);        
    }
#line 1712 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 81:
#line 601 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFieldRef);        
    }
#line 1721 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 82:
#line 607 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        VALUE args[] = {(((yyGLRStackItem const *)yyvsp)[YYFILL (-4)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval)};
        ((*yyvalp)) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFieldTypeRef);        
    }
#line 1730 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 83:
#line 615 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1739 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 84:
#line 621 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1747 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 93:
#line 650 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("i8");
    }
#line 1755 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 94:
#line 655 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("i16");
    }
#line 1763 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 95:
#line 660 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("i32");
    }
#line 1771 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 96:
#line 665 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("i64");
    }
#line 1779 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 97:
#line 670 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("u8");
    }
#line 1787 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 98:
#line 675 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("u16");
    }
#line 1795 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 99:
#line 680 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("u32");
    }
#line 1803 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 100:
#line 685 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("u64");
    }
#line 1811 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 101:
#line 690 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("f64");
    }
#line 1819 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 102:
#line 695 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("decimal");
    }
#line 1827 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 103:
#line 700 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("date");
    }
#line 1835 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 104:
#line 705 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("timeOfDayMilli");
    }
#line 1843 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 105:
#line 710 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("timeOfDayNano");
    }
#line 1851 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 106:
#line 715 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("nanoTime");
    }
#line 1859 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 107:
#line 720 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("milliTime");
    }
#line 1867 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 108:
#line 725 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("boolean");
    }
#line 1875 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 109:
#line 730 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("string");
    }
#line 1883 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 110:
#line 735 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("binary");
    }
#line 1891 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 111:
#line 740 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("fixed");
    }
#line 1899 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 112:
#line 745 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("object");
    }
#line 1907 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 113:
#line 750 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("namespace");
    }
#line 1915 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 114:
#line 755 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("type");
    }
#line 1923 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 115:
#line 760 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = rb_str_new2("schema");
    }
#line 1931 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 119:
#line 777 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1939 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;

  case 125:
#line 802 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:783  */
    {
        ((*yyvalp)) = Qnil;
    }
#line 1947 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
    break;


#line 1951 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:783  */
      default: break;
    }

  return yyok;
# undef yyerrok
# undef YYABORT
# undef YYACCEPT
# undef YYERROR
# undef YYBACKUP
# undef yyclearin
# undef YYRECOVERING
}


static void
yyuserMerge (int yyn, YYSTYPE* yy0, YYSTYPE* yy1)
{
  YYUSE (yy0);
  YYUSE (yy1);

  switch (yyn)
    {

      default: break;
    }
}

                              /* Bison grammar-table manipulation.  */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  YYUSE (scanner);
  YYUSE (filename);
  YYUSE (tree);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}

/** Number of symbols composing the right hand side of rule #RULE.  */
static inline int
yyrhsLength (yyRuleNum yyrule)
{
  return yyr2[yyrule];
}

static void
yydestroyGLRState (char const *yymsg, yyGLRState *yys, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  if (yys->yyresolved)
    yydestruct (yymsg, yystos[yys->yylrState],
                &yys->yysemantics.yysval, &yys->yyloc, scanner, filename, tree);
  else
    {
#if YYDEBUG
      if (yydebug)
        {
          if (yys->yysemantics.yyfirstVal)
            YYFPRINTF (stderr, "%s unresolved", yymsg);
          else
            YYFPRINTF (stderr, "%s incomplete", yymsg);
          YY_SYMBOL_PRINT ("", yystos[yys->yylrState], YY_NULLPTR, &yys->yyloc);
        }
#endif

      if (yys->yysemantics.yyfirstVal)
        {
          yySemanticOption *yyoption = yys->yysemantics.yyfirstVal;
          yyGLRState *yyrh;
          int yyn;
          for (yyrh = yyoption->yystate, yyn = yyrhsLength (yyoption->yyrule);
               yyn > 0;
               yyrh = yyrh->yypred, yyn -= 1)
            yydestroyGLRState (yymsg, yyrh, scanner, filename, tree);
        }
    }
}

/** Left-hand-side symbol for rule #YYRULE.  */
static inline yySymbol
yylhsNonterm (yyRuleNum yyrule)
{
  return yyr1[yyrule];
}

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-89)))

/** True iff LR state YYSTATE has only a default reduction (regardless
 *  of token).  */
static inline yybool
yyisDefaultedState (yyStateNum yystate)
{
  return yypact_value_is_default (yypact[yystate]);
}

/** The default reduction for YYSTATE, assuming it has one.  */
static inline yyRuleNum
yydefaultAction (yyStateNum yystate)
{
  return yydefact[yystate];
}

#define yytable_value_is_error(Yytable_value) \
  0

/** Set *YYACTION to the action to take in YYSTATE on seeing YYTOKEN.
 *  Result R means
 *    R < 0:  Reduce on rule -R.
 *    R = 0:  Error.
 *    R > 0:  Shift to state R.
 *  Set *YYCONFLICTS to a pointer into yyconfl to a 0-terminated list
 *  of conflicting reductions.
 */
static inline void
yygetLRActions (yyStateNum yystate, int yytoken,
                int* yyaction, const short int** yyconflicts)
{
  int yyindex = yypact[yystate] + yytoken;
  if (yypact_value_is_default (yypact[yystate])
      || yyindex < 0 || YYLAST < yyindex || yycheck[yyindex] != yytoken)
    {
      *yyaction = -yydefact[yystate];
      *yyconflicts = yyconfl;
    }
  else if (! yytable_value_is_error (yytable[yyindex]))
    {
      *yyaction = yytable[yyindex];
      *yyconflicts = yyconfl + yyconflp[yyindex];
    }
  else
    {
      *yyaction = 0;
      *yyconflicts = yyconfl + yyconflp[yyindex];
    }
}

/** Compute post-reduction state.
 * \param yystate   the current state
 * \param yysym     the nonterminal to push on the stack
 */
static inline yyStateNum
yyLRgotoState (yyStateNum yystate, yySymbol yysym)
{
  int yyr = yypgoto[yysym - YYNTOKENS] + yystate;
  if (0 <= yyr && yyr <= YYLAST && yycheck[yyr] == yystate)
    return yytable[yyr];
  else
    return yydefgoto[yysym - YYNTOKENS];
}

static inline yybool
yyisShiftAction (int yyaction)
{
  return 0 < yyaction;
}

static inline yybool
yyisErrorAction (int yyaction)
{
  return yyaction == 0;
}

                                /* GLRStates */

/** Return a fresh GLRStackItem in YYSTACKP.  The item is an LR state
 *  if YYISSTATE, and otherwise a semantic option.  Callers should call
 *  YY_RESERVE_GLRSTACK afterwards to make sure there is sufficient
 *  headroom.  */

static inline yyGLRStackItem*
yynewGLRStackItem (yyGLRStack* yystackp, yybool yyisState)
{
  yyGLRStackItem* yynewItem = yystackp->yynextFree;
  yystackp->yyspaceLeft -= 1;
  yystackp->yynextFree += 1;
  yynewItem->yystate.yyisState = yyisState;
  return yynewItem;
}

/** Add a new semantic action that will execute the action for rule
 *  YYRULE on the semantic values in YYRHS to the list of
 *  alternative actions for YYSTATE.  Assumes that YYRHS comes from
 *  stack #YYK of *YYSTACKP. */
static void
yyaddDeferredAction (yyGLRStack* yystackp, size_t yyk, yyGLRState* yystate,
                     yyGLRState* yyrhs, yyRuleNum yyrule)
{
  yySemanticOption* yynewOption =
    &yynewGLRStackItem (yystackp, yyfalse)->yyoption;
  YYASSERT (!yynewOption->yyisState);
  yynewOption->yystate = yyrhs;
  yynewOption->yyrule = yyrule;
  if (yystackp->yytops.yylookaheadNeeds[yyk])
    {
      yynewOption->yyrawchar = yychar;
      yynewOption->yyval = yylval;
      yynewOption->yyloc = yylloc;
    }
  else
    yynewOption->yyrawchar = YYEMPTY;
  yynewOption->yynext = yystate->yysemantics.yyfirstVal;
  yystate->yysemantics.yyfirstVal = yynewOption;

  YY_RESERVE_GLRSTACK (yystackp);
}

                                /* GLRStacks */

/** Initialize YYSET to a singleton set containing an empty stack.  */
static yybool
yyinitStateSet (yyGLRStateSet* yyset)
{
  yyset->yysize = 1;
  yyset->yycapacity = 16;
  yyset->yystates = (yyGLRState**) YYMALLOC (16 * sizeof yyset->yystates[0]);
  if (! yyset->yystates)
    return yyfalse;
  yyset->yystates[0] = YY_NULLPTR;
  yyset->yylookaheadNeeds =
    (yybool*) YYMALLOC (16 * sizeof yyset->yylookaheadNeeds[0]);
  if (! yyset->yylookaheadNeeds)
    {
      YYFREE (yyset->yystates);
      return yyfalse;
    }
  return yytrue;
}

static void yyfreeStateSet (yyGLRStateSet* yyset)
{
  YYFREE (yyset->yystates);
  YYFREE (yyset->yylookaheadNeeds);
}

/** Initialize *YYSTACKP to a single empty stack, with total maximum
 *  capacity for all stacks of YYSIZE.  */
static yybool
yyinitGLRStack (yyGLRStack* yystackp, size_t yysize)
{
  yystackp->yyerrState = 0;
  yynerrs = 0;
  yystackp->yyspaceLeft = yysize;
  yystackp->yyitems =
    (yyGLRStackItem*) YYMALLOC (yysize * sizeof yystackp->yynextFree[0]);
  if (!yystackp->yyitems)
    return yyfalse;
  yystackp->yynextFree = yystackp->yyitems;
  yystackp->yysplitPoint = YY_NULLPTR;
  yystackp->yylastDeleted = YY_NULLPTR;
  return yyinitStateSet (&yystackp->yytops);
}


#if YYSTACKEXPANDABLE
# define YYRELOC(YYFROMITEMS,YYTOITEMS,YYX,YYTYPE) \
  &((YYTOITEMS) - ((YYFROMITEMS) - (yyGLRStackItem*) (YYX)))->YYTYPE

/** If *YYSTACKP is expandable, extend it.  WARNING: Pointers into the
    stack from outside should be considered invalid after this call.
    We always expand when there are 1 or fewer items left AFTER an
    allocation, so that we can avoid having external pointers exist
    across an allocation.  */
static void
yyexpandGLRStack (yyGLRStack* yystackp)
{
  yyGLRStackItem* yynewItems;
  yyGLRStackItem* yyp0, *yyp1;
  size_t yynewSize;
  size_t yyn;
  size_t yysize = yystackp->yynextFree - yystackp->yyitems;
  if (YYMAXDEPTH - YYHEADROOM < yysize)
    yyMemoryExhausted (yystackp);
  yynewSize = 2*yysize;
  if (YYMAXDEPTH < yynewSize)
    yynewSize = YYMAXDEPTH;
  yynewItems = (yyGLRStackItem*) YYMALLOC (yynewSize * sizeof yynewItems[0]);
  if (! yynewItems)
    yyMemoryExhausted (yystackp);
  for (yyp0 = yystackp->yyitems, yyp1 = yynewItems, yyn = yysize;
       0 < yyn;
       yyn -= 1, yyp0 += 1, yyp1 += 1)
    {
      *yyp1 = *yyp0;
      if (*(yybool *) yyp0)
        {
          yyGLRState* yys0 = &yyp0->yystate;
          yyGLRState* yys1 = &yyp1->yystate;
          if (yys0->yypred != YY_NULLPTR)
            yys1->yypred =
              YYRELOC (yyp0, yyp1, yys0->yypred, yystate);
          if (! yys0->yyresolved && yys0->yysemantics.yyfirstVal != YY_NULLPTR)
            yys1->yysemantics.yyfirstVal =
              YYRELOC (yyp0, yyp1, yys0->yysemantics.yyfirstVal, yyoption);
        }
      else
        {
          yySemanticOption* yyv0 = &yyp0->yyoption;
          yySemanticOption* yyv1 = &yyp1->yyoption;
          if (yyv0->yystate != YY_NULLPTR)
            yyv1->yystate = YYRELOC (yyp0, yyp1, yyv0->yystate, yystate);
          if (yyv0->yynext != YY_NULLPTR)
            yyv1->yynext = YYRELOC (yyp0, yyp1, yyv0->yynext, yyoption);
        }
    }
  if (yystackp->yysplitPoint != YY_NULLPTR)
    yystackp->yysplitPoint = YYRELOC (yystackp->yyitems, yynewItems,
                                      yystackp->yysplitPoint, yystate);

  for (yyn = 0; yyn < yystackp->yytops.yysize; yyn += 1)
    if (yystackp->yytops.yystates[yyn] != YY_NULLPTR)
      yystackp->yytops.yystates[yyn] =
        YYRELOC (yystackp->yyitems, yynewItems,
                 yystackp->yytops.yystates[yyn], yystate);
  YYFREE (yystackp->yyitems);
  yystackp->yyitems = yynewItems;
  yystackp->yynextFree = yynewItems + yysize;
  yystackp->yyspaceLeft = yynewSize - yysize;
}
#endif

static void
yyfreeGLRStack (yyGLRStack* yystackp)
{
  YYFREE (yystackp->yyitems);
  yyfreeStateSet (&yystackp->yytops);
}

/** Assuming that YYS is a GLRState somewhere on *YYSTACKP, update the
 *  splitpoint of *YYSTACKP, if needed, so that it is at least as deep as
 *  YYS.  */
static inline void
yyupdateSplit (yyGLRStack* yystackp, yyGLRState* yys)
{
  if (yystackp->yysplitPoint != YY_NULLPTR && yystackp->yysplitPoint > yys)
    yystackp->yysplitPoint = yys;
}

/** Invalidate stack #YYK in *YYSTACKP.  */
static inline void
yymarkStackDeleted (yyGLRStack* yystackp, size_t yyk)
{
  if (yystackp->yytops.yystates[yyk] != YY_NULLPTR)
    yystackp->yylastDeleted = yystackp->yytops.yystates[yyk];
  yystackp->yytops.yystates[yyk] = YY_NULLPTR;
}

/** Undelete the last stack in *YYSTACKP that was marked as deleted.  Can
    only be done once after a deletion, and only when all other stacks have
    been deleted.  */
static void
yyundeleteLastStack (yyGLRStack* yystackp)
{
  if (yystackp->yylastDeleted == YY_NULLPTR || yystackp->yytops.yysize != 0)
    return;
  yystackp->yytops.yystates[0] = yystackp->yylastDeleted;
  yystackp->yytops.yysize = 1;
  YYDPRINTF ((stderr, "Restoring last deleted stack as stack #0.\n"));
  yystackp->yylastDeleted = YY_NULLPTR;
}

static inline void
yyremoveDeletes (yyGLRStack* yystackp)
{
  size_t yyi, yyj;
  yyi = yyj = 0;
  while (yyj < yystackp->yytops.yysize)
    {
      if (yystackp->yytops.yystates[yyi] == YY_NULLPTR)
        {
          if (yyi == yyj)
            {
              YYDPRINTF ((stderr, "Removing dead stacks.\n"));
            }
          yystackp->yytops.yysize -= 1;
        }
      else
        {
          yystackp->yytops.yystates[yyj] = yystackp->yytops.yystates[yyi];
          /* In the current implementation, it's unnecessary to copy
             yystackp->yytops.yylookaheadNeeds[yyi] since, after
             yyremoveDeletes returns, the parser immediately either enters
             deterministic operation or shifts a token.  However, it doesn't
             hurt, and the code might evolve to need it.  */
          yystackp->yytops.yylookaheadNeeds[yyj] =
            yystackp->yytops.yylookaheadNeeds[yyi];
          if (yyj != yyi)
            {
              YYDPRINTF ((stderr, "Rename stack %lu -> %lu.\n",
                          (unsigned long int) yyi, (unsigned long int) yyj));
            }
          yyj += 1;
        }
      yyi += 1;
    }
}

/** Shift to a new state on stack #YYK of *YYSTACKP, corresponding to LR
 * state YYLRSTATE, at input position YYPOSN, with (resolved) semantic
 * value *YYVALP and source location *YYLOCP.  */
static inline void
yyglrShift (yyGLRStack* yystackp, size_t yyk, yyStateNum yylrState,
            size_t yyposn,
            YYSTYPE* yyvalp, YYLTYPE* yylocp)
{
  yyGLRState* yynewState = &yynewGLRStackItem (yystackp, yytrue)->yystate;

  yynewState->yylrState = yylrState;
  yynewState->yyposn = yyposn;
  yynewState->yyresolved = yytrue;
  yynewState->yypred = yystackp->yytops.yystates[yyk];
  yynewState->yysemantics.yysval = *yyvalp;
  yynewState->yyloc = *yylocp;
  yystackp->yytops.yystates[yyk] = yynewState;

  YY_RESERVE_GLRSTACK (yystackp);
}

/** Shift stack #YYK of *YYSTACKP, to a new state corresponding to LR
 *  state YYLRSTATE, at input position YYPOSN, with the (unresolved)
 *  semantic value of YYRHS under the action for YYRULE.  */
static inline void
yyglrShiftDefer (yyGLRStack* yystackp, size_t yyk, yyStateNum yylrState,
                 size_t yyposn, yyGLRState* yyrhs, yyRuleNum yyrule)
{
  yyGLRState* yynewState = &yynewGLRStackItem (yystackp, yytrue)->yystate;
  YYASSERT (yynewState->yyisState);

  yynewState->yylrState = yylrState;
  yynewState->yyposn = yyposn;
  yynewState->yyresolved = yyfalse;
  yynewState->yypred = yystackp->yytops.yystates[yyk];
  yynewState->yysemantics.yyfirstVal = YY_NULLPTR;
  yystackp->yytops.yystates[yyk] = yynewState;

  /* Invokes YY_RESERVE_GLRSTACK.  */
  yyaddDeferredAction (yystackp, yyk, yynewState, yyrhs, yyrule);
}

#if !YYDEBUG
# define YY_REDUCE_PRINT(Args)
#else
# define YY_REDUCE_PRINT(Args)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print Args;               \
} while (0)

/*----------------------------------------------------------------------.
| Report that stack #YYK of *YYSTACKP is going to be reduced by YYRULE. |
`----------------------------------------------------------------------*/

static inline void
yy_reduce_print (int yynormal, yyGLRStackItem* yyvsp, size_t yyk,
                 yyRuleNum yyrule, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  int yynrhs = yyrhsLength (yyrule);
  int yylow = 1;
  int yyi;
  YYFPRINTF (stderr, "Reducing stack %lu by rule %d (line %lu):\n",
             (unsigned long int) yyk, yyrule - 1,
             (unsigned long int) yyrline[yyrule]);
  if (! yynormal)
    yyfillin (yyvsp, 1, -yynrhs);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyvsp[yyi - yynrhs + 1].yystate.yylrState],
                       &yyvsp[yyi - yynrhs + 1].yystate.yysemantics.yysval
                       , &(((yyGLRStackItem const *)yyvsp)[YYFILL ((yyi + 1) - (yynrhs))].yystate.yyloc)                       , scanner, filename, tree);
      if (!yyvsp[yyi - yynrhs + 1].yystate.yyresolved)
        YYFPRINTF (stderr, " (unresolved)");
      YYFPRINTF (stderr, "\n");
    }
}
#endif

/** Pop the symbols consumed by reduction #YYRULE from the top of stack
 *  #YYK of *YYSTACKP, and perform the appropriate semantic action on their
 *  semantic values.  Assumes that all ambiguities in semantic values
 *  have been previously resolved.  Set *YYVALP to the resulting value,
 *  and *YYLOCP to the computed location (if any).  Return value is as
 *  for userAction.  */
static inline YYRESULTTAG
yydoAction (yyGLRStack* yystackp, size_t yyk, yyRuleNum yyrule,
            YYSTYPE* yyvalp, YYLTYPE *yylocp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  int yynrhs = yyrhsLength (yyrule);

  if (yystackp->yysplitPoint == YY_NULLPTR)
    {
      /* Standard special case: single stack.  */
      yyGLRStackItem* yyrhs = (yyGLRStackItem*) yystackp->yytops.yystates[yyk];
      YYASSERT (yyk == 0);
      yystackp->yynextFree -= yynrhs;
      yystackp->yyspaceLeft += yynrhs;
      yystackp->yytops.yystates[0] = & yystackp->yynextFree[-1].yystate;
      YY_REDUCE_PRINT ((1, yyrhs, yyk, yyrule, scanner, filename, tree));
      return yyuserAction (yyrule, yynrhs, yyrhs, yystackp,
                           yyvalp, yylocp, scanner, filename, tree);
    }
  else
    {
      int yyi;
      yyGLRState* yys;
      yyGLRStackItem yyrhsVals[YYMAXRHS + YYMAXLEFT + 1];
      yys = yyrhsVals[YYMAXRHS + YYMAXLEFT].yystate.yypred
        = yystackp->yytops.yystates[yyk];
      if (yynrhs == 0)
        /* Set default location.  */
        yyrhsVals[YYMAXRHS + YYMAXLEFT - 1].yystate.yyloc = yys->yyloc;
      for (yyi = 0; yyi < yynrhs; yyi += 1)
        {
          yys = yys->yypred;
          YYASSERT (yys);
        }
      yyupdateSplit (yystackp, yys);
      yystackp->yytops.yystates[yyk] = yys;
      YY_REDUCE_PRINT ((0, yyrhsVals + YYMAXRHS + YYMAXLEFT - 1, yyk, yyrule, scanner, filename, tree));
      return yyuserAction (yyrule, yynrhs, yyrhsVals + YYMAXRHS + YYMAXLEFT - 1,
                           yystackp, yyvalp, yylocp, scanner, filename, tree);
    }
}

/** Pop items off stack #YYK of *YYSTACKP according to grammar rule YYRULE,
 *  and push back on the resulting nonterminal symbol.  Perform the
 *  semantic action associated with YYRULE and store its value with the
 *  newly pushed state, if YYFORCEEVAL or if *YYSTACKP is currently
 *  unambiguous.  Otherwise, store the deferred semantic action with
 *  the new state.  If the new state would have an identical input
 *  position, LR state, and predecessor to an existing state on the stack,
 *  it is identified with that existing state, eliminating stack #YYK from
 *  *YYSTACKP.  In this case, the semantic value is
 *  added to the options for the existing state's semantic value.
 */
static inline YYRESULTTAG
yyglrReduce (yyGLRStack* yystackp, size_t yyk, yyRuleNum yyrule,
             yybool yyforceEval, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  size_t yyposn = yystackp->yytops.yystates[yyk]->yyposn;

  if (yyforceEval || yystackp->yysplitPoint == YY_NULLPTR)
    {
      YYSTYPE yysval;
      YYLTYPE yyloc;

      YYRESULTTAG yyflag = yydoAction (yystackp, yyk, yyrule, &yysval, &yyloc, scanner, filename, tree);
      if (yyflag == yyerr && yystackp->yysplitPoint != YY_NULLPTR)
        {
          YYDPRINTF ((stderr, "Parse on stack %lu rejected by rule #%d.\n",
                     (unsigned long int) yyk, yyrule - 1));
        }
      if (yyflag != yyok)
        return yyflag;
      YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyrule], &yysval, &yyloc);
      yyglrShift (yystackp, yyk,
                  yyLRgotoState (yystackp->yytops.yystates[yyk]->yylrState,
                                 yylhsNonterm (yyrule)),
                  yyposn, &yysval, &yyloc);
    }
  else
    {
      size_t yyi;
      int yyn;
      yyGLRState* yys, *yys0 = yystackp->yytops.yystates[yyk];
      yyStateNum yynewLRState;

      for (yys = yystackp->yytops.yystates[yyk], yyn = yyrhsLength (yyrule);
           0 < yyn; yyn -= 1)
        {
          yys = yys->yypred;
          YYASSERT (yys);
        }
      yyupdateSplit (yystackp, yys);
      yynewLRState = yyLRgotoState (yys->yylrState, yylhsNonterm (yyrule));
      YYDPRINTF ((stderr,
                  "Reduced stack %lu by rule #%d; action deferred.  "
                  "Now in state %d.\n",
                  (unsigned long int) yyk, yyrule - 1, yynewLRState));
      for (yyi = 0; yyi < yystackp->yytops.yysize; yyi += 1)
        if (yyi != yyk && yystackp->yytops.yystates[yyi] != YY_NULLPTR)
          {
            yyGLRState *yysplit = yystackp->yysplitPoint;
            yyGLRState *yyp = yystackp->yytops.yystates[yyi];
            while (yyp != yys && yyp != yysplit && yyp->yyposn >= yyposn)
              {
                if (yyp->yylrState == yynewLRState && yyp->yypred == yys)
                  {
                    yyaddDeferredAction (yystackp, yyk, yyp, yys0, yyrule);
                    yymarkStackDeleted (yystackp, yyk);
                    YYDPRINTF ((stderr, "Merging stack %lu into stack %lu.\n",
                                (unsigned long int) yyk,
                                (unsigned long int) yyi));
                    return yyok;
                  }
                yyp = yyp->yypred;
              }
          }
      yystackp->yytops.yystates[yyk] = yys;
      yyglrShiftDefer (yystackp, yyk, yynewLRState, yyposn, yys0, yyrule);
    }
  return yyok;
}

static size_t
yysplitStack (yyGLRStack* yystackp, size_t yyk)
{
  if (yystackp->yysplitPoint == YY_NULLPTR)
    {
      YYASSERT (yyk == 0);
      yystackp->yysplitPoint = yystackp->yytops.yystates[yyk];
    }
  if (yystackp->yytops.yysize >= yystackp->yytops.yycapacity)
    {
      yyGLRState** yynewStates;
      yybool* yynewLookaheadNeeds;

      yynewStates = YY_NULLPTR;

      if (yystackp->yytops.yycapacity
          > (YYSIZEMAX / (2 * sizeof yynewStates[0])))
        yyMemoryExhausted (yystackp);
      yystackp->yytops.yycapacity *= 2;

      yynewStates =
        (yyGLRState**) YYREALLOC (yystackp->yytops.yystates,
                                  (yystackp->yytops.yycapacity
                                   * sizeof yynewStates[0]));
      if (yynewStates == YY_NULLPTR)
        yyMemoryExhausted (yystackp);
      yystackp->yytops.yystates = yynewStates;

      yynewLookaheadNeeds =
        (yybool*) YYREALLOC (yystackp->yytops.yylookaheadNeeds,
                             (yystackp->yytops.yycapacity
                              * sizeof yynewLookaheadNeeds[0]));
      if (yynewLookaheadNeeds == YY_NULLPTR)
        yyMemoryExhausted (yystackp);
      yystackp->yytops.yylookaheadNeeds = yynewLookaheadNeeds;
    }
  yystackp->yytops.yystates[yystackp->yytops.yysize]
    = yystackp->yytops.yystates[yyk];
  yystackp->yytops.yylookaheadNeeds[yystackp->yytops.yysize]
    = yystackp->yytops.yylookaheadNeeds[yyk];
  yystackp->yytops.yysize += 1;
  return yystackp->yytops.yysize-1;
}

/** True iff YYY0 and YYY1 represent identical options at the top level.
 *  That is, they represent the same rule applied to RHS symbols
 *  that produce the same terminal symbols.  */
static yybool
yyidenticalOptions (yySemanticOption* yyy0, yySemanticOption* yyy1)
{
  if (yyy0->yyrule == yyy1->yyrule)
    {
      yyGLRState *yys0, *yys1;
      int yyn;
      for (yys0 = yyy0->yystate, yys1 = yyy1->yystate,
           yyn = yyrhsLength (yyy0->yyrule);
           yyn > 0;
           yys0 = yys0->yypred, yys1 = yys1->yypred, yyn -= 1)
        if (yys0->yyposn != yys1->yyposn)
          return yyfalse;
      return yytrue;
    }
  else
    return yyfalse;
}

/** Assuming identicalOptions (YYY0,YYY1), destructively merge the
 *  alternative semantic values for the RHS-symbols of YYY1 and YYY0.  */
static void
yymergeOptionSets (yySemanticOption* yyy0, yySemanticOption* yyy1)
{
  yyGLRState *yys0, *yys1;
  int yyn;
  for (yys0 = yyy0->yystate, yys1 = yyy1->yystate,
       yyn = yyrhsLength (yyy0->yyrule);
       yyn > 0;
       yys0 = yys0->yypred, yys1 = yys1->yypred, yyn -= 1)
    {
      if (yys0 == yys1)
        break;
      else if (yys0->yyresolved)
        {
          yys1->yyresolved = yytrue;
          yys1->yysemantics.yysval = yys0->yysemantics.yysval;
        }
      else if (yys1->yyresolved)
        {
          yys0->yyresolved = yytrue;
          yys0->yysemantics.yysval = yys1->yysemantics.yysval;
        }
      else
        {
          yySemanticOption** yyz0p = &yys0->yysemantics.yyfirstVal;
          yySemanticOption* yyz1 = yys1->yysemantics.yyfirstVal;
          while (yytrue)
            {
              if (yyz1 == *yyz0p || yyz1 == YY_NULLPTR)
                break;
              else if (*yyz0p == YY_NULLPTR)
                {
                  *yyz0p = yyz1;
                  break;
                }
              else if (*yyz0p < yyz1)
                {
                  yySemanticOption* yyz = *yyz0p;
                  *yyz0p = yyz1;
                  yyz1 = yyz1->yynext;
                  (*yyz0p)->yynext = yyz;
                }
              yyz0p = &(*yyz0p)->yynext;
            }
          yys1->yysemantics.yyfirstVal = yys0->yysemantics.yyfirstVal;
        }
    }
}

/** Y0 and Y1 represent two possible actions to take in a given
 *  parsing state; return 0 if no combination is possible,
 *  1 if user-mergeable, 2 if Y0 is preferred, 3 if Y1 is preferred.  */
static int
yypreference (yySemanticOption* y0, yySemanticOption* y1)
{
  yyRuleNum r0 = y0->yyrule, r1 = y1->yyrule;
  int p0 = yydprec[r0], p1 = yydprec[r1];

  if (p0 == p1)
    {
      if (yymerger[r0] == 0 || yymerger[r0] != yymerger[r1])
        return 0;
      else
        return 1;
    }
  if (p0 == 0 || p1 == 0)
    return 0;
  if (p0 < p1)
    return 3;
  if (p1 < p0)
    return 2;
  return 0;
}

static YYRESULTTAG yyresolveValue (yyGLRState* yys,
                                   yyGLRStack* yystackp, yyscan_t scanner, VALUE filename, VALUE *tree);


/** Resolve the previous YYN states starting at and including state YYS
 *  on *YYSTACKP. If result != yyok, some states may have been left
 *  unresolved possibly with empty semantic option chains.  Regardless
 *  of whether result = yyok, each state has been left with consistent
 *  data so that yydestroyGLRState can be invoked if necessary.  */
static YYRESULTTAG
yyresolveStates (yyGLRState* yys, int yyn,
                 yyGLRStack* yystackp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  if (0 < yyn)
    {
      YYASSERT (yys->yypred);
      YYCHK (yyresolveStates (yys->yypred, yyn-1, yystackp, scanner, filename, tree));
      if (! yys->yyresolved)
        YYCHK (yyresolveValue (yys, yystackp, scanner, filename, tree));
    }
  return yyok;
}

/** Resolve the states for the RHS of YYOPT on *YYSTACKP, perform its
 *  user action, and return the semantic value and location in *YYVALP
 *  and *YYLOCP.  Regardless of whether result = yyok, all RHS states
 *  have been destroyed (assuming the user action destroys all RHS
 *  semantic values if invoked).  */
static YYRESULTTAG
yyresolveAction (yySemanticOption* yyopt, yyGLRStack* yystackp,
                 YYSTYPE* yyvalp, YYLTYPE *yylocp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  yyGLRStackItem yyrhsVals[YYMAXRHS + YYMAXLEFT + 1];
  int yynrhs = yyrhsLength (yyopt->yyrule);
  YYRESULTTAG yyflag =
    yyresolveStates (yyopt->yystate, yynrhs, yystackp, scanner, filename, tree);
  if (yyflag != yyok)
    {
      yyGLRState *yys;
      for (yys = yyopt->yystate; yynrhs > 0; yys = yys->yypred, yynrhs -= 1)
        yydestroyGLRState ("Cleanup: popping", yys, scanner, filename, tree);
      return yyflag;
    }

  yyrhsVals[YYMAXRHS + YYMAXLEFT].yystate.yypred = yyopt->yystate;
  if (yynrhs == 0)
    /* Set default location.  */
    yyrhsVals[YYMAXRHS + YYMAXLEFT - 1].yystate.yyloc = yyopt->yystate->yyloc;
  {
    int yychar_current = yychar;
    YYSTYPE yylval_current = yylval;
    YYLTYPE yylloc_current = yylloc;
    yychar = yyopt->yyrawchar;
    yylval = yyopt->yyval;
    yylloc = yyopt->yyloc;
    yyflag = yyuserAction (yyopt->yyrule, yynrhs,
                           yyrhsVals + YYMAXRHS + YYMAXLEFT - 1,
                           yystackp, yyvalp, yylocp, scanner, filename, tree);
    yychar = yychar_current;
    yylval = yylval_current;
    yylloc = yylloc_current;
  }
  return yyflag;
}

#if YYDEBUG
static void
yyreportTree (yySemanticOption* yyx, int yyindent)
{
  int yynrhs = yyrhsLength (yyx->yyrule);
  int yyi;
  yyGLRState* yys;
  yyGLRState* yystates[1 + YYMAXRHS];
  yyGLRState yyleftmost_state;

  for (yyi = yynrhs, yys = yyx->yystate; 0 < yyi; yyi -= 1, yys = yys->yypred)
    yystates[yyi] = yys;
  if (yys == YY_NULLPTR)
    {
      yyleftmost_state.yyposn = 0;
      yystates[0] = &yyleftmost_state;
    }
  else
    yystates[0] = yys;

  if (yyx->yystate->yyposn < yys->yyposn + 1)
    YYFPRINTF (stderr, "%*s%s -> <Rule %d, empty>\n",
               yyindent, "", yytokenName (yylhsNonterm (yyx->yyrule)),
               yyx->yyrule - 1);
  else
    YYFPRINTF (stderr, "%*s%s -> <Rule %d, tokens %lu .. %lu>\n",
               yyindent, "", yytokenName (yylhsNonterm (yyx->yyrule)),
               yyx->yyrule - 1, (unsigned long int) (yys->yyposn + 1),
               (unsigned long int) yyx->yystate->yyposn);
  for (yyi = 1; yyi <= yynrhs; yyi += 1)
    {
      if (yystates[yyi]->yyresolved)
        {
          if (yystates[yyi-1]->yyposn+1 > yystates[yyi]->yyposn)
            YYFPRINTF (stderr, "%*s%s <empty>\n", yyindent+2, "",
                       yytokenName (yystos[yystates[yyi]->yylrState]));
          else
            YYFPRINTF (stderr, "%*s%s <tokens %lu .. %lu>\n", yyindent+2, "",
                       yytokenName (yystos[yystates[yyi]->yylrState]),
                       (unsigned long int) (yystates[yyi-1]->yyposn + 1),
                       (unsigned long int) yystates[yyi]->yyposn);
        }
      else
        yyreportTree (yystates[yyi]->yysemantics.yyfirstVal, yyindent+2);
    }
}
#endif

static YYRESULTTAG
yyreportAmbiguity (yySemanticOption* yyx0,
                   yySemanticOption* yyx1, YYLTYPE *yylocp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  YYUSE (yyx0);
  YYUSE (yyx1);

#if YYDEBUG
  YYFPRINTF (stderr, "Ambiguity detected.\n");
  YYFPRINTF (stderr, "Option 1,\n");
  yyreportTree (yyx0, 2);
  YYFPRINTF (stderr, "\nOption 2,\n");
  yyreportTree (yyx1, 2);
  YYFPRINTF (stderr, "\n");
#endif

  yyerror (yylocp, scanner, filename, tree, YY_("syntax is ambiguous"));
  return yyabort;
}

/** Resolve the locations for each of the YYN1 states in *YYSTACKP,
 *  ending at YYS1.  Has no effect on previously resolved states.
 *  The first semantic option of a state is always chosen.  */
static void
yyresolveLocations (yyGLRState* yys1, int yyn1,
                    yyGLRStack *yystackp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  if (0 < yyn1)
    {
      yyresolveLocations (yys1->yypred, yyn1 - 1, yystackp, scanner, filename, tree);
      if (!yys1->yyresolved)
        {
          yyGLRStackItem yyrhsloc[1 + YYMAXRHS];
          int yynrhs;
          yySemanticOption *yyoption = yys1->yysemantics.yyfirstVal;
          YYASSERT (yyoption != YY_NULLPTR);
          yynrhs = yyrhsLength (yyoption->yyrule);
          if (yynrhs > 0)
            {
              yyGLRState *yys;
              int yyn;
              yyresolveLocations (yyoption->yystate, yynrhs,
                                  yystackp, scanner, filename, tree);
              for (yys = yyoption->yystate, yyn = yynrhs;
                   yyn > 0;
                   yys = yys->yypred, yyn -= 1)
                yyrhsloc[yyn].yystate.yyloc = yys->yyloc;
            }
          else
            {
              /* Both yyresolveAction and yyresolveLocations traverse the GSS
                 in reverse rightmost order.  It is only necessary to invoke
                 yyresolveLocations on a subforest for which yyresolveAction
                 would have been invoked next had an ambiguity not been
                 detected.  Thus the location of the previous state (but not
                 necessarily the previous state itself) is guaranteed to be
                 resolved already.  */
              yyGLRState *yyprevious = yyoption->yystate;
              yyrhsloc[0].yystate.yyloc = yyprevious->yyloc;
            }
          {
            int yychar_current = yychar;
            YYSTYPE yylval_current = yylval;
            YYLTYPE yylloc_current = yylloc;
            yychar = yyoption->yyrawchar;
            yylval = yyoption->yyval;
            yylloc = yyoption->yyloc;
            YYLLOC_DEFAULT ((yys1->yyloc), yyrhsloc, yynrhs);
            yychar = yychar_current;
            yylval = yylval_current;
            yylloc = yylloc_current;
          }
        }
    }
}

/** Resolve the ambiguity represented in state YYS in *YYSTACKP,
 *  perform the indicated actions, and set the semantic value of YYS.
 *  If result != yyok, the chain of semantic options in YYS has been
 *  cleared instead or it has been left unmodified except that
 *  redundant options may have been removed.  Regardless of whether
 *  result = yyok, YYS has been left with consistent data so that
 *  yydestroyGLRState can be invoked if necessary.  */
static YYRESULTTAG
yyresolveValue (yyGLRState* yys, yyGLRStack* yystackp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  yySemanticOption* yyoptionList = yys->yysemantics.yyfirstVal;
  yySemanticOption* yybest = yyoptionList;
  yySemanticOption** yypp;
  yybool yymerge = yyfalse;
  YYSTYPE yysval;
  YYRESULTTAG yyflag;
  YYLTYPE *yylocp = &yys->yyloc;

  for (yypp = &yyoptionList->yynext; *yypp != YY_NULLPTR; )
    {
      yySemanticOption* yyp = *yypp;

      if (yyidenticalOptions (yybest, yyp))
        {
          yymergeOptionSets (yybest, yyp);
          *yypp = yyp->yynext;
        }
      else
        {
          switch (yypreference (yybest, yyp))
            {
            case 0:
              yyresolveLocations (yys, 1, yystackp, scanner, filename, tree);
              return yyreportAmbiguity (yybest, yyp, yylocp, scanner, filename, tree);
              break;
            case 1:
              yymerge = yytrue;
              break;
            case 2:
              break;
            case 3:
              yybest = yyp;
              yymerge = yyfalse;
              break;
            default:
              /* This cannot happen so it is not worth a YYASSERT (yyfalse),
                 but some compilers complain if the default case is
                 omitted.  */
              break;
            }
          yypp = &yyp->yynext;
        }
    }

  if (yymerge)
    {
      yySemanticOption* yyp;
      int yyprec = yydprec[yybest->yyrule];
      yyflag = yyresolveAction (yybest, yystackp, &yysval, yylocp, scanner, filename, tree);
      if (yyflag == yyok)
        for (yyp = yybest->yynext; yyp != YY_NULLPTR; yyp = yyp->yynext)
          {
            if (yyprec == yydprec[yyp->yyrule])
              {
                YYSTYPE yysval_other;
                YYLTYPE yydummy;
                yyflag = yyresolveAction (yyp, yystackp, &yysval_other, &yydummy, scanner, filename, tree);
                if (yyflag != yyok)
                  {
                    yydestruct ("Cleanup: discarding incompletely merged value for",
                                yystos[yys->yylrState],
                                &yysval, yylocp, scanner, filename, tree);
                    break;
                  }
                yyuserMerge (yymerger[yyp->yyrule], &yysval, &yysval_other);
              }
          }
    }
  else
    yyflag = yyresolveAction (yybest, yystackp, &yysval, yylocp, scanner, filename, tree);

  if (yyflag == yyok)
    {
      yys->yyresolved = yytrue;
      yys->yysemantics.yysval = yysval;
    }
  else
    yys->yysemantics.yyfirstVal = YY_NULLPTR;
  return yyflag;
}

static YYRESULTTAG
yyresolveStack (yyGLRStack* yystackp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  if (yystackp->yysplitPoint != YY_NULLPTR)
    {
      yyGLRState* yys;
      int yyn;

      for (yyn = 0, yys = yystackp->yytops.yystates[0];
           yys != yystackp->yysplitPoint;
           yys = yys->yypred, yyn += 1)
        continue;
      YYCHK (yyresolveStates (yystackp->yytops.yystates[0], yyn, yystackp
                             , scanner, filename, tree));
    }
  return yyok;
}

static void
yycompressStack (yyGLRStack* yystackp)
{
  yyGLRState* yyp, *yyq, *yyr;

  if (yystackp->yytops.yysize != 1 || yystackp->yysplitPoint == YY_NULLPTR)
    return;

  for (yyp = yystackp->yytops.yystates[0], yyq = yyp->yypred, yyr = YY_NULLPTR;
       yyp != yystackp->yysplitPoint;
       yyr = yyp, yyp = yyq, yyq = yyp->yypred)
    yyp->yypred = yyr;

  yystackp->yyspaceLeft += yystackp->yynextFree - yystackp->yyitems;
  yystackp->yynextFree = ((yyGLRStackItem*) yystackp->yysplitPoint) + 1;
  yystackp->yyspaceLeft -= yystackp->yynextFree - yystackp->yyitems;
  yystackp->yysplitPoint = YY_NULLPTR;
  yystackp->yylastDeleted = YY_NULLPTR;

  while (yyr != YY_NULLPTR)
    {
      yystackp->yynextFree->yystate = *yyr;
      yyr = yyr->yypred;
      yystackp->yynextFree->yystate.yypred = &yystackp->yynextFree[-1].yystate;
      yystackp->yytops.yystates[0] = &yystackp->yynextFree->yystate;
      yystackp->yynextFree += 1;
      yystackp->yyspaceLeft -= 1;
    }
}

static YYRESULTTAG
yyprocessOneStack (yyGLRStack* yystackp, size_t yyk,
                   size_t yyposn, YYLTYPE *yylocp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  while (yystackp->yytops.yystates[yyk] != YY_NULLPTR)
    {
      yyStateNum yystate = yystackp->yytops.yystates[yyk]->yylrState;
      YYDPRINTF ((stderr, "Stack %lu Entering state %d\n",
                  (unsigned long int) yyk, yystate));

      YYASSERT (yystate != YYFINAL);

      if (yyisDefaultedState (yystate))
        {
          YYRESULTTAG yyflag;
          yyRuleNum yyrule = yydefaultAction (yystate);
          if (yyrule == 0)
            {
              YYDPRINTF ((stderr, "Stack %lu dies.\n",
                          (unsigned long int) yyk));
              yymarkStackDeleted (yystackp, yyk);
              return yyok;
            }
          yyflag = yyglrReduce (yystackp, yyk, yyrule, yyimmediate[yyrule], scanner, filename, tree);
          if (yyflag == yyerr)
            {
              YYDPRINTF ((stderr,
                          "Stack %lu dies "
                          "(predicate failure or explicit user error).\n",
                          (unsigned long int) yyk));
              yymarkStackDeleted (yystackp, yyk);
              return yyok;
            }
          if (yyflag != yyok)
            return yyflag;
        }
      else
        {
          yySymbol yytoken;
          int yyaction;
          const short int* yyconflicts;

          yystackp->yytops.yylookaheadNeeds[yyk] = yytrue;
          if (yychar == YYEMPTY)
            {
              YYDPRINTF ((stderr, "Reading a token: "));
              yychar = yylex (&yylval, &yylloc, scanner);
            }

          if (yychar <= YYEOF)
            {
              yychar = yytoken = YYEOF;
              YYDPRINTF ((stderr, "Now at end of input.\n"));
            }
          else
            {
              yytoken = YYTRANSLATE (yychar);
              YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
            }

          yygetLRActions (yystate, yytoken, &yyaction, &yyconflicts);

          while (*yyconflicts != 0)
            {
              YYRESULTTAG yyflag;
              size_t yynewStack = yysplitStack (yystackp, yyk);
              YYDPRINTF ((stderr, "Splitting off stack %lu from %lu.\n",
                          (unsigned long int) yynewStack,
                          (unsigned long int) yyk));
              yyflag = yyglrReduce (yystackp, yynewStack,
                                    *yyconflicts,
                                    yyimmediate[*yyconflicts], scanner, filename, tree);
              if (yyflag == yyok)
                YYCHK (yyprocessOneStack (yystackp, yynewStack,
                                          yyposn, yylocp, scanner, filename, tree));
              else if (yyflag == yyerr)
                {
                  YYDPRINTF ((stderr, "Stack %lu dies.\n",
                              (unsigned long int) yynewStack));
                  yymarkStackDeleted (yystackp, yynewStack);
                }
              else
                return yyflag;
              yyconflicts += 1;
            }

          if (yyisShiftAction (yyaction))
            break;
          else if (yyisErrorAction (yyaction))
            {
              YYDPRINTF ((stderr, "Stack %lu dies.\n",
                          (unsigned long int) yyk));
              yymarkStackDeleted (yystackp, yyk);
              break;
            }
          else
            {
              YYRESULTTAG yyflag = yyglrReduce (yystackp, yyk, -yyaction,
                                                yyimmediate[-yyaction], scanner, filename, tree);
              if (yyflag == yyerr)
                {
                  YYDPRINTF ((stderr,
                              "Stack %lu dies "
                              "(predicate failure or explicit user error).\n",
                              (unsigned long int) yyk));
                  yymarkStackDeleted (yystackp, yyk);
                  break;
                }
              else if (yyflag != yyok)
                return yyflag;
            }
        }
    }
  return yyok;
}

static void
yyreportSyntaxError (yyGLRStack* yystackp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  if (yystackp->yyerrState != 0)
    return;
#if ! YYERROR_VERBOSE
  yyerror (&yylloc, scanner, filename, tree, YY_("syntax error"));
#else
  {
  yySymbol yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);
  size_t yysize0 = yytnamerr (YY_NULLPTR, yytokenName (yytoken));
  size_t yysize = yysize0;
  yybool yysize_overflow = yyfalse;
  char* yymsg = YY_NULLPTR;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected").  */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[yystackp->yytops.yystates[0]->yylrState];
      yyarg[yycount++] = yytokenName (yytoken);
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for this
             state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;
          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytokenName (yyx);
                {
                  size_t yysz = yysize + yytnamerr (YY_NULLPTR, yytokenName (yyx));
                  yysize_overflow |= yysz < yysize;
                  yysize = yysz;
                }
              }
        }
    }

  switch (yycount)
    {
#define YYCASE_(N, S)                   \
      case N:                           \
        yyformat = S;                   \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
#undef YYCASE_
    }

  {
    size_t yysz = yysize + strlen (yyformat);
    yysize_overflow |= yysz < yysize;
    yysize = yysz;
  }

  if (!yysize_overflow)
    yymsg = (char *) YYMALLOC (yysize);

  if (yymsg)
    {
      char *yyp = yymsg;
      int yyi = 0;
      while ((*yyp = *yyformat))
        {
          if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
            {
              yyp += yytnamerr (yyp, yyarg[yyi++]);
              yyformat += 2;
            }
          else
            {
              yyp++;
              yyformat++;
            }
        }
      yyerror (&yylloc, scanner, filename, tree, yymsg);
      YYFREE (yymsg);
    }
  else
    {
      yyerror (&yylloc, scanner, filename, tree, YY_("syntax error"));
      yyMemoryExhausted (yystackp);
    }
  }
#endif /* YYERROR_VERBOSE */
  yynerrs += 1;
}

/* Recover from a syntax error on *YYSTACKP, assuming that *YYSTACKP->YYTOKENP,
   yylval, and yylloc are the syntactic category, semantic value, and location
   of the lookahead.  */
static void
yyrecoverSyntaxError (yyGLRStack* yystackp, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  size_t yyk;
  int yyj;

  if (yystackp->yyerrState == 3)
    /* We just shifted the error token and (perhaps) took some
       reductions.  Skip tokens until we can proceed.  */
    while (yytrue)
      {
        yySymbol yytoken;
        if (yychar == YYEOF)
          yyFail (yystackp, &yylloc, scanner, filename, tree, YY_NULLPTR);
        if (yychar != YYEMPTY)
          {
            /* We throw away the lookahead, but the error range
               of the shifted error token must take it into account.  */
            yyGLRState *yys = yystackp->yytops.yystates[0];
            yyGLRStackItem yyerror_range[3];
            yyerror_range[1].yystate.yyloc = yys->yyloc;
            yyerror_range[2].yystate.yyloc = yylloc;
            YYLLOC_DEFAULT ((yys->yyloc), yyerror_range, 2);
            yytoken = YYTRANSLATE (yychar);
            yydestruct ("Error: discarding",
                        yytoken, &yylval, &yylloc, scanner, filename, tree);
          }
        YYDPRINTF ((stderr, "Reading a token: "));
        yychar = yylex (&yylval, &yylloc, scanner);
        if (yychar <= YYEOF)
          {
            yychar = yytoken = YYEOF;
            YYDPRINTF ((stderr, "Now at end of input.\n"));
          }
        else
          {
            yytoken = YYTRANSLATE (yychar);
            YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
          }
        yyj = yypact[yystackp->yytops.yystates[0]->yylrState];
        if (yypact_value_is_default (yyj))
          return;
        yyj += yytoken;
        if (yyj < 0 || YYLAST < yyj || yycheck[yyj] != yytoken)
          {
            if (yydefact[yystackp->yytops.yystates[0]->yylrState] != 0)
              return;
          }
        else if (! yytable_value_is_error (yytable[yyj]))
          return;
      }

  /* Reduce to one stack.  */
  for (yyk = 0; yyk < yystackp->yytops.yysize; yyk += 1)
    if (yystackp->yytops.yystates[yyk] != YY_NULLPTR)
      break;
  if (yyk >= yystackp->yytops.yysize)
    yyFail (yystackp, &yylloc, scanner, filename, tree, YY_NULLPTR);
  for (yyk += 1; yyk < yystackp->yytops.yysize; yyk += 1)
    yymarkStackDeleted (yystackp, yyk);
  yyremoveDeletes (yystackp);
  yycompressStack (yystackp);

  /* Now pop stack until we find a state that shifts the error token.  */
  yystackp->yyerrState = 3;
  while (yystackp->yytops.yystates[0] != YY_NULLPTR)
    {
      yyGLRState *yys = yystackp->yytops.yystates[0];
      yyj = yypact[yys->yylrState];
      if (! yypact_value_is_default (yyj))
        {
          yyj += YYTERROR;
          if (0 <= yyj && yyj <= YYLAST && yycheck[yyj] == YYTERROR
              && yyisShiftAction (yytable[yyj]))
            {
              /* Shift the error token.  */
              /* First adjust its location.*/
              YYLTYPE yyerrloc;
              yystackp->yyerror_range[2].yystate.yyloc = yylloc;
              YYLLOC_DEFAULT (yyerrloc, (yystackp->yyerror_range), 2);
              YY_SYMBOL_PRINT ("Shifting", yystos[yytable[yyj]],
                               &yylval, &yyerrloc);
              yyglrShift (yystackp, 0, yytable[yyj],
                          yys->yyposn, &yylval, &yyerrloc);
              yys = yystackp->yytops.yystates[0];
              break;
            }
        }
      yystackp->yyerror_range[1].yystate.yyloc = yys->yyloc;
      if (yys->yypred != YY_NULLPTR)
        yydestroyGLRState ("Error: popping", yys, scanner, filename, tree);
      yystackp->yytops.yystates[0] = yys->yypred;
      yystackp->yynextFree -= 1;
      yystackp->yyspaceLeft += 1;
    }
  if (yystackp->yytops.yystates[0] == YY_NULLPTR)
    yyFail (yystackp, &yylloc, scanner, filename, tree, YY_NULLPTR);
}

#define YYCHK1(YYE)                                                          \
  do {                                                                       \
    switch (YYE) {                                                           \
    case yyok:                                                               \
      break;                                                                 \
    case yyabort:                                                            \
      goto yyabortlab;                                                       \
    case yyaccept:                                                           \
      goto yyacceptlab;                                                      \
    case yyerr:                                                              \
      goto yyuser_error;                                                     \
    default:                                                                 \
      goto yybuglab;                                                         \
    }                                                                        \
  } while (0)

/*----------.
| yyparse.  |
`----------*/

int
yyparse (yyscan_t scanner, VALUE filename, VALUE *tree)
{
  int yyresult;
  yyGLRStack yystack;
  yyGLRStack* const yystackp = &yystack;
  size_t yyposn;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY;
  yylval = yyval_default;
  yylloc = yyloc_default;

  if (! yyinitGLRStack (yystackp, YYINITDEPTH))
    goto yyexhaustedlab;
  switch (YYSETJMP (yystack.yyexception_buffer))
    {
    case 0: break;
    case 1: goto yyabortlab;
    case 2: goto yyexhaustedlab;
    default: goto yybuglab;
    }
  yyglrShift (&yystack, 0, 0, 0, &yylval, &yylloc);
  yyposn = 0;

  while (yytrue)
    {
      /* For efficiency, we have two loops, the first of which is
         specialized to deterministic operation (single stack, no
         potential ambiguity).  */
      /* Standard mode */
      while (yytrue)
        {
          yyRuleNum yyrule;
          int yyaction;
          const short int* yyconflicts;

          yyStateNum yystate = yystack.yytops.yystates[0]->yylrState;
          YYDPRINTF ((stderr, "Entering state %d\n", yystate));
          if (yystate == YYFINAL)
            goto yyacceptlab;
          if (yyisDefaultedState (yystate))
            {
              yyrule = yydefaultAction (yystate);
              if (yyrule == 0)
                {
               yystack.yyerror_range[1].yystate.yyloc = yylloc;
                  yyreportSyntaxError (&yystack, scanner, filename, tree);
                  goto yyuser_error;
                }
              YYCHK1 (yyglrReduce (&yystack, 0, yyrule, yytrue, scanner, filename, tree));
            }
          else
            {
              yySymbol yytoken;
              if (yychar == YYEMPTY)
                {
                  YYDPRINTF ((stderr, "Reading a token: "));
                  yychar = yylex (&yylval, &yylloc, scanner);
                }

              if (yychar <= YYEOF)
                {
                  yychar = yytoken = YYEOF;
                  YYDPRINTF ((stderr, "Now at end of input.\n"));
                }
              else
                {
                  yytoken = YYTRANSLATE (yychar);
                  YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
                }

              yygetLRActions (yystate, yytoken, &yyaction, &yyconflicts);
              if (*yyconflicts != 0)
                break;
              if (yyisShiftAction (yyaction))
                {
                  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
                  yychar = YYEMPTY;
                  yyposn += 1;
                  yyglrShift (&yystack, 0, yyaction, yyposn, &yylval, &yylloc);
                  if (0 < yystack.yyerrState)
                    yystack.yyerrState -= 1;
                }
              else if (yyisErrorAction (yyaction))
                {
               yystack.yyerror_range[1].yystate.yyloc = yylloc;
                  yyreportSyntaxError (&yystack, scanner, filename, tree);
                  goto yyuser_error;
                }
              else
                YYCHK1 (yyglrReduce (&yystack, 0, -yyaction, yytrue, scanner, filename, tree));
            }
        }

      while (yytrue)
        {
          yySymbol yytoken_to_shift;
          size_t yys;

          for (yys = 0; yys < yystack.yytops.yysize; yys += 1)
            yystackp->yytops.yylookaheadNeeds[yys] = yychar != YYEMPTY;

          /* yyprocessOneStack returns one of three things:

              - An error flag.  If the caller is yyprocessOneStack, it
                immediately returns as well.  When the caller is finally
                yyparse, it jumps to an error label via YYCHK1.

              - yyok, but yyprocessOneStack has invoked yymarkStackDeleted
                (&yystack, yys), which sets the top state of yys to NULL.  Thus,
                yyparse's following invocation of yyremoveDeletes will remove
                the stack.

              - yyok, when ready to shift a token.

             Except in the first case, yyparse will invoke yyremoveDeletes and
             then shift the next token onto all remaining stacks.  This
             synchronization of the shift (that is, after all preceding
             reductions on all stacks) helps prevent double destructor calls
             on yylval in the event of memory exhaustion.  */

          for (yys = 0; yys < yystack.yytops.yysize; yys += 1)
            YYCHK1 (yyprocessOneStack (&yystack, yys, yyposn, &yylloc, scanner, filename, tree));
          yyremoveDeletes (&yystack);
          if (yystack.yytops.yysize == 0)
            {
              yyundeleteLastStack (&yystack);
              if (yystack.yytops.yysize == 0)
                yyFail (&yystack, &yylloc, scanner, filename, tree, YY_("syntax error"));
              YYCHK1 (yyresolveStack (&yystack, scanner, filename, tree));
              YYDPRINTF ((stderr, "Returning to deterministic operation.\n"));
           yystack.yyerror_range[1].yystate.yyloc = yylloc;
              yyreportSyntaxError (&yystack, scanner, filename, tree);
              goto yyuser_error;
            }

          /* If any yyglrShift call fails, it will fail after shifting.  Thus,
             a copy of yylval will already be on stack 0 in the event of a
             failure in the following loop.  Thus, yychar is set to YYEMPTY
             before the loop to make sure the user destructor for yylval isn't
             called twice.  */
          yytoken_to_shift = YYTRANSLATE (yychar);
          yychar = YYEMPTY;
          yyposn += 1;
          for (yys = 0; yys < yystack.yytops.yysize; yys += 1)
            {
              int yyaction;
              const short int* yyconflicts;
              yyStateNum yystate = yystack.yytops.yystates[yys]->yylrState;
              yygetLRActions (yystate, yytoken_to_shift, &yyaction,
                              &yyconflicts);
              /* Note that yyconflicts were handled by yyprocessOneStack.  */
              YYDPRINTF ((stderr, "On stack %lu, ", (unsigned long int) yys));
              YY_SYMBOL_PRINT ("shifting", yytoken_to_shift, &yylval, &yylloc);
              yyglrShift (&yystack, yys, yyaction, yyposn,
                          &yylval, &yylloc);
              YYDPRINTF ((stderr, "Stack %lu now in state #%d\n",
                          (unsigned long int) yys,
                          yystack.yytops.yystates[yys]->yylrState));
            }

          if (yystack.yytops.yysize == 1)
            {
              YYCHK1 (yyresolveStack (&yystack, scanner, filename, tree));
              YYDPRINTF ((stderr, "Returning to deterministic operation.\n"));
              yycompressStack (&yystack);
              break;
            }
        }
      continue;
    yyuser_error:
      yyrecoverSyntaxError (&yystack, scanner, filename, tree);
      yyposn = yystack.yytops.yystates[0]->yyposn;
    }

 yyacceptlab:
  yyresult = 0;
  goto yyreturn;

 yybuglab:
  YYASSERT (yyfalse);
  goto yyabortlab;

 yyabortlab:
  yyresult = 1;
  goto yyreturn;

 yyexhaustedlab:
  yyerror (&yylloc, scanner, filename, tree, YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturn;

 yyreturn:
  if (yychar != YYEMPTY)
    yydestruct ("Cleanup: discarding lookahead",
                YYTRANSLATE (yychar), &yylval, &yylloc, scanner, filename, tree);

  /* If the stack is well-formed, pop the stack until it is empty,
     destroying its entries as we go.  But free the stack regardless
     of whether it is well-formed.  */
  if (yystack.yyitems)
    {
      yyGLRState** yystates = yystack.yytops.yystates;
      if (yystates)
        {
          size_t yysize = yystack.yytops.yysize;
          size_t yyk;
          for (yyk = 0; yyk < yysize; yyk += 1)
            if (yystates[yyk])
              {
                while (yystates[yyk])
                  {
                    yyGLRState *yys = yystates[yyk];
                 yystack.yyerror_range[1].yystate.yyloc = yys->yyloc;
                  if (yys->yypred != YY_NULLPTR)
                      yydestroyGLRState ("Cleanup: popping", yys, scanner, filename, tree);
                    yystates[yyk] = yys->yypred;
                    yystack.yynextFree -= 1;
                    yystack.yyspaceLeft += 1;
                  }
                break;
              }
        }
      yyfreeGLRStack (&yystack);
    }

  return yyresult;
}

/* DEBUGGING ONLY */
#if YYDEBUG
static void
yy_yypstack (yyGLRState* yys)
{
  if (yys->yypred)
    {
      yy_yypstack (yys->yypred);
      YYFPRINTF (stderr, " -> ");
    }
  YYFPRINTF (stderr, "%d@%lu", yys->yylrState,
             (unsigned long int) yys->yyposn);
}

static void
yypstates (yyGLRState* yyst)
{
  if (yyst == YY_NULLPTR)
    YYFPRINTF (stderr, "<null>");
  else
    yy_yypstack (yyst);
  YYFPRINTF (stderr, "\n");
}

static void
yypstack (yyGLRStack* yystackp, size_t yyk)
{
  yypstates (yystackp->yytops.yystates[yyk]);
}

#define YYINDEX(YYX)                                                         \
    ((YYX) == YY_NULLPTR ? -1 : (yyGLRStackItem*) (YYX) - yystackp->yyitems)


static void
yypdumpstack (yyGLRStack* yystackp)
{
  yyGLRStackItem* yyp;
  size_t yyi;
  for (yyp = yystackp->yyitems; yyp < yystackp->yynextFree; yyp += 1)
    {
      YYFPRINTF (stderr, "%3lu. ",
                 (unsigned long int) (yyp - yystackp->yyitems));
      if (*(yybool *) yyp)
        {
          YYASSERT (yyp->yystate.yyisState);
          YYASSERT (yyp->yyoption.yyisState);
          YYFPRINTF (stderr, "Res: %d, LR State: %d, posn: %lu, pred: %ld",
                     yyp->yystate.yyresolved, yyp->yystate.yylrState,
                     (unsigned long int) yyp->yystate.yyposn,
                     (long int) YYINDEX (yyp->yystate.yypred));
          if (! yyp->yystate.yyresolved)
            YYFPRINTF (stderr, ", firstVal: %ld",
                       (long int) YYINDEX (yyp->yystate
                                             .yysemantics.yyfirstVal));
        }
      else
        {
          YYASSERT (!yyp->yystate.yyisState);
          YYASSERT (!yyp->yyoption.yyisState);
          YYFPRINTF (stderr, "Option. rule: %d, state: %ld, next: %ld",
                     yyp->yyoption.yyrule - 1,
                     (long int) YYINDEX (yyp->yyoption.yystate),
                     (long int) YYINDEX (yyp->yyoption.yynext));
        }
      YYFPRINTF (stderr, "\n");
    }
  YYFPRINTF (stderr, "Tops:");
  for (yyi = 0; yyi < yystackp->yytops.yysize; yyi += 1)
    YYFPRINTF (stderr, "%lu: %ld; ", (unsigned long int) yyi,
               (long int) YYINDEX (yystackp->yytops.yystates[yyi]));
  YYFPRINTF (stderr, "\n");
}
#endif

#undef yylval
#undef yychar
#undef yynerrs
#undef yylloc



#line 807 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:2551  */


/* functions **********************************************************/


void Init_ext_schema_parser(void)
{
    cSlowBlink = rb_define_module("SlowBlink");

    cNamespace = rb_const_get(cSlowBlink, rb_intern("Namespace"));
    cGroup = rb_const_get(cSlowBlink, rb_intern("Group"));
    cField = rb_const_get(cSlowBlink, rb_intern("Field"));
    cDefinition = rb_const_get(cSlowBlink, rb_intern("Definition"));

    cNameWithID = rb_const_get(cSlowBlink, rb_intern("NameWithID"));
    
    cAnnotation = rb_const_get(cSlowBlink, rb_intern("Annotation"));
    cIncrementalAnnotation = rb_const_get(cSlowBlink, rb_intern("IncrementalAnnotation"));

    cENUMERATION = rb_const_get(cSlowBlink, rb_intern("ENUMERATION"));
    cSym = rb_const_get(cSlowBlink, rb_intern("Sym"));

    cU8 = rb_const_get(cSlowBlink, rb_intern("U8"));
    cU16 = rb_const_get(cSlowBlink, rb_intern("U16"));
    cU32 = rb_const_get(cSlowBlink, rb_intern("U32"));
    cU64 = rb_const_get(cSlowBlink, rb_intern("U64"));
    cI8 = rb_const_get(cSlowBlink, rb_intern("I8"));
    cI16 = rb_const_get(cSlowBlink, rb_intern("I16"));
    cI32 = rb_const_get(cSlowBlink, rb_intern("I32"));
    cI64 = rb_const_get(cSlowBlink, rb_intern("I64"));
    cFLOATING_POINT = rb_const_get(cSlowBlink, rb_intern("FLOATING_POINT"));
    cDECIMAL = rb_const_get(cSlowBlink, rb_intern("DECIMAL"));
    cFIXED = rb_const_get(cSlowBlink, rb_intern("FIXED"));
    cBINARY = rb_const_get(cSlowBlink, rb_intern("BINARY"));
    cSTRING = rb_const_get(cSlowBlink, rb_intern("STRING"));
    cBOOLEAN = rb_const_get(cSlowBlink, rb_intern("BOOLEAN"));
    cDATE = rb_const_get(cSlowBlink, rb_intern("DATE"));
    cMILLI_TIME = rb_const_get(cSlowBlink, rb_intern("MILLI_TIME"));
    cNANO_TIME = rb_const_get(cSlowBlink, rb_intern("NANO_TIME"));
    cTIME_OF_DAY_MILLI = rb_const_get(cSlowBlink, rb_intern("TIME_OF_DAY_MILLI"));
    cTIME_OF_DAY_NANO = rb_const_get(cSlowBlink, rb_intern("TIME_OF_DAY_NANO"));
    cSEQUENCE = rb_const_get(cSlowBlink, rb_intern("SEQUENCE"));
    cREF = rb_const_get(cSlowBlink, rb_intern("REF"));
    cOBJECT = rb_const_get(cSlowBlink, rb_intern("OBJECT"));

    cSchemaRef = rb_const_get(cSlowBlink, rb_intern("SchemaRef"));
    cDefinitionRef = rb_const_get(cSlowBlink, rb_intern("DefinitionRef"));
    cDefinitionTypeRef = rb_const_get(cSlowBlink, rb_intern("DefinitionTypeRef"));
    cFieldRef = rb_const_get(cSlowBlink, rb_intern("FieldRef"));
    cFieldTypeRef = rb_const_get(cSlowBlink, rb_intern("FieldTypeRef"));

    cLog = rb_const_get(cSlowBlink, rb_intern("Log"));

    rb_define_singleton_method(cNamespace, "parse", parseFileBuffer, -1);
}

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg, ... )
{
    VALUE message = newLocation(filename, locp);
    rb_str_append(message, rb_str_new2(": error: "));
    rb_str_append(message, rb_str_new2(msg));
    rb_funcall(cLog, rb_intern("error"), 1, message);
}

/* static functions ***************************************************/

static VALUE parseFileBuffer(int argc, VALUE* argv, VALUE self)
{
    yyscan_t scanner;    
    VALUE tree = Qnil;
    VALUE buffer;
    VALUE opts;
    VALUE filename;

    rb_scan_args(argc, argv, "10:", &buffer, &opts);

    if(opts == Qnil){
        opts = rb_hash_new();
    }

    filename = rb_hash_aref(opts, ID2SYM(rb_intern("filename")));

    if(yylex_init(&scanner) == 0){

            if(yy_scan_bytes((const char *)RSTRING_PTR(buffer), RSTRING_LEN(buffer), scanner)){

            yyparse(scanner, filename, &tree);
        }

        yylex_destroy(scanner);
    }

    return tree;
}

static VALUE newLocation(VALUE filename, const YYLTYPE *location)
{
    char msg[500];    
    int len = 0;

    if(filename != Qnil){

        len = snprintf(msg, sizeof(msg), "%s:%i:%i", (const char *)RSTRING_PTR(filename), location->first_line, location->first_column);
    }
    else{

        len = snprintf(msg, sizeof(msg), "%i:%i", location->first_line, location->first_column);
    }
    
    return rb_str_new(msg, len);
}
