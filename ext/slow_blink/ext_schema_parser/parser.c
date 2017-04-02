/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Skeleton implementation for Bison GLR parsers in C

   Copyright (C) 2002-2015 Free Software Foundation, Inc.

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
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "glr.c"

/* Pure parsers.  */
#define YYPURE 1






/* First part of user declarations.  */
#line 6 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:240  */


typedef void * yyscan_t;
#define YY_TYPEDEF_YY_SCANNER_T

#include <ruby.h>

#include "parser.h"
#include "lexer.h"

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg);

static VALUE parseFileBuffer(int argc, VALUE* argv, VALUE self);
static VALUE newLocation(VALUE filename, const YYLTYPE *locp);

static VALUE cSlowBlink;
static VALUE cParseError;


#line 74 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:240  */

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

#line 107 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:263  */

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
#define YYFINAL  10
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   188

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  50
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  48
/* YYNRULES -- Number of rules.  */
#define YYNRULES  125
/* YYNRULES -- Number of states.  */
#define YYNSTATES  159
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
       0,    75,    75,    82,    88,    97,   104,   109,   116,   122,
     128,   132,   143,   145,   149,   161,   163,   172,   177,   184,
     190,   197,   211,   216,   223,   225,   229,   234,   236,   238,
     243,   248,   250,   257,   266,   273,   279,   288,   294,   303,
     313,   318,   325,   332,   342,   349,   356,   363,   370,   377,
     384,   391,   398,   405,   414,   421,   428,   435,   442,   452,
     460,   467,   475,   482,   492,   494,   499,   506,   511,   515,
     521,   527,   535,   537,   544,   554,   556,   561,   568,   578,
     585,   592,   600,   608,   619,   625,   632,   634,   636,   638,
     642,   644,   648,   650,   654,   659,   664,   669,   674,   679,
     684,   689,   694,   699,   704,   709,   714,   719,   724,   729,
     734,   739,   744,   749,   754,   759,   764,   771,   775,   777,
     781,   785,   787,   791,   795,   799
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "EOF", "error", "$undefined", "\"i8\"", "\"i16\"", "\"i32\"", "\"i64\"",
  "\"u8\"", "\"u16\"", "\"u32\"", "\"u64\"", "\"f64\"", "\"decimal\"",
  "\"date\"", "\"timeOfDayMilli\"", "\"timeOfDayNano\"", "\"nanotime\"",
  "\"millitime\"", "\"boolean\"", "\"string\"", "\"object\"",
  "\"namespace\"", "\"type\"", "\"schema\"", "\"binary\"", "\"fixed\"",
  "\"<-\"", "\"->\"", "\"hexnum\"", "\"uint\"", "\"int\"", "\"name\"",
  "\"ncName\"", "\"\\\\ncName\"", "\"cName\"",
  "\"\\\"<annotation>\\\" or '<annotation>'\"", "UNKNOWN", "'='", "':'",
  "','", "'?'", "'['", "']'", "'('", "')'", "'*'", "'|'", "'/'", "'@'",
  "'.'", "$accept", "top", "namespace", "nsDecl", "defs", "def", "define",
  "enumOrType", "groupDef", "super", "body", "fields", "field", "opt",
  "type", "single", "sequence", "string", "binary", "fixed", "size", "ref",
  "number", "time", "enum", "symList", "sym", "val", "annots", "annotList",
  "annot", "literal", "nameWithId", "id", "incrAnnot", "compRef",
  "incrAnnotList", "incrAnnotItem", "qName", "qNameOrKeyword", "keyword",
  "cName", "name", "literalSegment", "int", "uInt", "hexNum", "e", YY_NULLPTR
};
#endif

#define YYPACT_NINF -91
#define YYTABLE_NINF -63

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const short int yypact[] =
{
      19,   -13,    17,   -91,   -91,    67,   -91,   -91,   -91,   -91,
     -91,    70,   -91,   -91,    64,   -91,   -13,     7,   -91,   -91,
      33,    14,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,    28,
     -91,   -91,   -91,     9,    -3,   -91,    77,    68,   -17,    60,
      18,   -23,    81,   -91,    29,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,    77,   -91,    61,   -91,    60,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,    66,   -91,    66,    66,     7,   -91,
     -91,    71,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
      73,   -91,   -13,    72,   -91,     7,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,    91,   -91,    29,   -91,   -91,   -91,   -91,
      74,     7,    75,   -91,    82,   -91,   154,   -91,    76,    79,
     -91,    80,   -16,   -91,   -91,     7,     7,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,   -13,    87,   -91,   -91,   -91
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const unsigned char yydefact[] =
{
     125,     0,     0,     2,   125,     3,     6,   118,   119,     5,
       1,     4,    79,   117,     0,     7,     0,    68,    69,    10,
       0,    80,    91,    90,    67,    94,    95,    96,    97,    98,
      99,   100,   101,   102,   103,   104,   105,   106,   107,   108,
     109,   110,   113,   114,   115,   116,   111,   112,    92,     0,
      93,     8,     9,   125,   125,    70,     0,    78,     0,     0,
       0,     0,   125,    15,     0,    74,    75,    88,    87,    86,
      89,    84,     0,    81,    82,   120,    71,    72,    44,    45,
      46,    47,    48,    49,    50,    51,    52,    53,    54,    55,
      56,    57,    58,    32,    35,    33,    37,     0,   125,    11,
      13,    24,    25,    29,    30,    31,    26,    28,    27,    12,
       0,    61,     0,    42,    16,   125,    14,    17,   124,   123,
      76,    77,    85,     0,    73,     0,    36,    38,    39,    59,
       0,   125,   125,    43,    18,    19,     0,    83,     0,     0,
      34,    60,     0,    63,    64,   125,   125,    40,    41,   122,
     121,    65,    66,    20,     0,   125,    23,    21,    22
};

  /* YYPGOTO[NTERM-NUM].  */
static const signed char yypgoto[] =
{
     -91,   -91,   -91,   -91,   124,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,   -15,   -91,    -7,   -91,   -91,   -91,   -91,   -91,
      -5,   -91,   -91,   -91,   -91,   -91,   -90,   -91,    -4,   -91,
     -11,   -91,   -21,   -91,   -91,   -91,   -91,    59,   -12,   -91,
     -91,   -91,     2,    58,   -91,    10,   -86,     0
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const short int yydefgoto[] =
{
      -1,     2,     3,     4,     5,    15,    51,    99,    52,    62,
     116,   134,   135,   157,   100,   101,   102,   103,   104,   105,
     126,   106,   107,   108,   109,   110,   111,   143,   112,    17,
      18,    76,    53,    65,    19,    20,    57,    71,    21,    49,
      50,    22,    23,    77,   151,   120,   121,    24
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const short int yytable[] =
{
       6,    16,    48,     9,     6,    73,    55,    16,   129,     7,
       8,    13,   118,   149,   150,     7,     8,    10,    54,     7,
       8,    78,    79,    80,    81,    82,    83,    84,    85,    86,
      87,    88,    89,    90,    91,    92,    93,    94,    95,   139,
       1,   141,    96,    97,    64,    70,    60,    61,   113,   114,
       7,     8,    13,    63,    66,    14,   152,   118,   119,    56,
      74,    70,   117,    58,    98,    59,    14,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    44,    45,    46,    47,
      12,   127,   128,    12,    72,    75,     7,     8,    13,     7,
       8,    13,     7,     8,    13,    67,    68,    69,   115,   125,
     123,   136,   130,   137,   132,    14,   140,   133,    14,   131,
     147,   145,   142,   148,   113,    14,   -62,   156,    11,   146,
     153,   122,   144,   155,   124,   138,     0,     0,     0,     0,
       0,   136,   154,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   158,    54,    78,    79,    80,
      81,    82,    83,    84,    85,    86,    87,    88,    89,    90,
      91,    92,    93,    94,    95,     0,     0,     0,    96,    97,
       0,     0,     0,     0,     0,     0,     7,     8,    13
};

static const short int yycheck[] =
{
       0,     5,    14,     1,     4,    22,    17,    11,    98,    32,
      33,    34,    28,    29,    30,    32,    33,     0,    16,    32,
      33,     3,     4,     5,     6,     7,     8,     9,    10,    11,
      12,    13,    14,    15,    16,    17,    18,    19,    20,   125,
      21,   131,    24,    25,    47,    56,    37,    38,    60,    61,
      32,    33,    34,    53,    54,    48,   142,    28,    29,    26,
      58,    72,    62,    49,    46,    37,    48,     3,     4,     5,
       6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
      23,    96,    97,    23,    26,    35,    32,    33,    34,    32,
      33,    34,    32,    33,    34,    28,    29,    30,    27,    43,
      49,   115,    41,    22,   112,    48,    42,    45,    48,    46,
      44,    39,    47,    44,   136,    48,    46,    40,     4,   136,
     145,    72,   132,   154,    76,   125,    -1,    -1,    -1,    -1,
      -1,   145,   146,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,   155,   154,     3,     4,     5,
       6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    19,    20,    -1,    -1,    -1,    24,    25,
      -1,    -1,    -1,    -1,    -1,    -1,    32,    33,    34
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,    21,    51,    52,    53,    54,    97,    32,    33,    92,
       0,    54,    23,    34,    48,    55,    78,    79,    80,    84,
      85,    88,    91,    92,    97,     3,     4,     5,     6,     7,
       8,     9,    10,    11,    12,    13,    14,    15,    16,    17,
      18,    19,    20,    21,    22,    23,    24,    25,    88,    89,
      90,    56,    58,    82,    92,    80,    26,    86,    49,    37,
      37,    38,    59,    97,    47,    83,    97,    28,    29,    30,
      80,    87,    26,    22,    92,    35,    81,    93,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    24,    25,    46,    57,
      64,    65,    66,    67,    68,    69,    71,    72,    73,    74,
      75,    76,    78,    88,    88,    27,    60,    97,    28,    29,
      95,    96,    87,    49,    93,    43,    70,    70,    70,    76,
      41,    46,    92,    45,    61,    62,    78,    22,    95,    96,
      42,    76,    47,    77,    97,    39,    64,    44,    44,    29,
      30,    94,    96,    62,    78,    82,    40,    63,    97
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    50,    51,    52,    52,    53,    54,    54,    55,    55,
      55,    56,    57,    57,    58,    59,    59,    60,    60,    61,
      61,    62,    63,    63,    64,    64,    65,    65,    65,    65,
      65,    65,    65,    65,    66,    67,    67,    68,    68,    69,
      70,    70,    71,    71,    72,    72,    72,    72,    72,    72,
      72,    72,    72,    72,    73,    73,    73,    73,    73,    74,
      74,    75,    75,    76,    77,    77,    77,    78,    78,    79,
      79,    80,    81,    81,    82,    83,    83,    83,    84,    85,
      85,    85,    85,    85,    86,    86,    87,    87,    87,    87,
      88,    88,    89,    89,    90,    90,    90,    90,    90,    90,
      90,    90,    90,    90,    90,    90,    90,    90,    90,    90,
      90,    90,    90,    90,    90,    90,    90,    91,    92,    92,
      93,    94,    94,    95,    96,    97
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     1,     1,     2,     2,     1,     2,     2,     2,
       1,     3,     1,     1,     3,     1,     2,     1,     2,     1,
       3,     5,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     3,     1,     2,     1,     2,     2,
       3,     3,     1,     2,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     2,
       3,     1,     3,     3,     1,     2,     2,     1,     1,     1,
       2,     4,     1,     2,     2,     1,     2,     2,     2,     1,
       1,     3,     3,     5,     2,     3,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
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
       9,    11,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     1,
       3,     0,     5,     7,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0
};

/* YYCONFL[I] -- lists of conflicting rule numbers, each terminated by
   0, pointed into by YYCONFLP.  */
static const short int yyconfl[] =
{
       0,   125,     0,   125,     0,   125,     0,   125,     0,   125,
       0,   125,     0
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
#line 76 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        *tree = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1088 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 3:
#line 83 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("defs")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)); 
    }
#line 1097 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 4:
#line 89 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("defs")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval)); 
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval)); 
    }
#line 1107 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 5:
#line 98 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1115 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 6:
#line 105 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_ary_new();
    }
#line 1123 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 7:
#line 110 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1131 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 8:
#line 117 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("annotes")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
    }
#line 1140 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 9:
#line 123 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);        
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("annotes")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
    }
#line 1149 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 11:
#line 133 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("Definition")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("type")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1161 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 14:
#line 150 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("Group")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("super")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("fields")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1174 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 16:
#line 164 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yyloc)));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1184 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 17:
#line 173 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_ary_new();
    }
#line 1192 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 18:
#line 178 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1200 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 19:
#line 185 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));        
    }
#line 1209 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 20:
#line 191 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1217 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 21:
#line 198 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("Field")));
        rb_hash_aset((((yyGLRStackItem const *)yyvsp)[YYFILL (-3)].yystate.yysemantics.yysval), ID2SYM(rb_intern("annotes")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-4)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("type")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-3)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("annotes")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("optional")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));        
    }
#line 1232 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 22:
#line 212 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = Qfalse;
    }
#line 1240 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 23:
#line 217 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = Qtrue;
    }
#line 1248 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 26:
#line 230 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("REF")));
    }
#line 1256 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 29:
#line 239 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("STRING")));
    }
#line 1264 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 30:
#line 244 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("BINARY")));
    }
#line 1272 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 32:
#line 251 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("BOOLEAN")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1282 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 33:
#line 258 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("OBJECT")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1292 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 34:
#line 267 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("sequence")), Qtrue);
    }
#line 1300 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 35:
#line 274 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();        
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1309 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 36:
#line 280 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("size")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1319 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 37:
#line 289 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1328 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 38:
#line 295 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("size")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1338 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 39:
#line 304 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("FIXED")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("size")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));        
    }
#line 1349 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 40:
#line 314 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval);
    }
#line 1357 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 41:
#line 319 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval);
    }
#line 1365 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 42:
#line 326 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();        
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1375 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 43:
#line 333 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("dynamic")), Qtrue);
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1386 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 44:
#line 343 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I8")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1396 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 45:
#line 350 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I16")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1406 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 46:
#line 357 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I32")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1416 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 47:
#line 364 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I64")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1426 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 48:
#line 371 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U8")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1436 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 49:
#line 378 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U16")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1446 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 50:
#line 385 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U32")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1456 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 51:
#line 392 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U64")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1466 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 52:
#line 399 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("FLOATING_POINT")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1476 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 53:
#line 406 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("DECIMAL")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1486 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 54:
#line 415 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("DATE")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1496 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 55:
#line 422 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("TIME_OF_DAY_MILLI")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1506 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 56:
#line 429 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("TIME_OF_DAY_NANO")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1516 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 57:
#line 436 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("NANO_TIME")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1526 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 58:
#line 443 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("MILLI_TIME")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1536 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 59:
#line 453 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("ENUM")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("syms")), rb_ary_new());
        rb_ary_push(rb_hash_aref(((*yyvalp)), ID2SYM(rb_intern("syms"))), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1547 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 60:
#line 461 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_ary_push(rb_hash_aref(((*yyvalp)), ID2SYM(rb_intern("syms"))), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1555 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 61:
#line 468 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("ENUM")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("syms")), rb_ary_new());
        rb_ary_push(rb_hash_aref(((*yyvalp)), ID2SYM(rb_intern("syms"))), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1566 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 62:
#line 476 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_ary_push(rb_hash_aref(((*yyvalp)), ID2SYM(rb_intern("syms"))), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1574 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 63:
#line 483 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("annotes")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("value")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));        
    }
#line 1585 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 65:
#line 495 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1593 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 66:
#line 500 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1601 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 67:
#line 507 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_ary_new();
    }
#line 1609 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 69:
#line 516 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));        
    }
#line 1618 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 70:
#line 522 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1626 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 71:
#line 528 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));    
    }
#line 1635 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 73:
#line 538 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_str_append(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1643 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 74:
#line 545 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-1)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("id")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1654 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 76:
#line 557 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1662 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 77:
#line 562 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval);
    }
#line 1670 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 78:
#line 569 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("class")), ID2SYM(rb_intern("IncrementalAnnotation")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("annotes")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1681 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 79:
#line 579 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), ID2SYM(rb_intern("SCHEMA")));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1691 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 80:
#line 586 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1701 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 81:
#line 593 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("type")), Qtrue);
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1712 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 82:
#line 601 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1723 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 83:
#line 609 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_hash_new();
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("ref")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-4)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("type")), Qtrue);
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("name")), (((yyGLRStackItem const *)yyvsp)[YYFILL (-2)].yystate.yysemantics.yysval));
        rb_hash_aset(((*yyvalp)), ID2SYM(rb_intern("loc")), newLocation(filename, &(*yylocp)));
    }
#line 1735 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 84:
#line 620 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_ary_new();
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1744 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 85:
#line 626 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        rb_ary_push(((*yyvalp)), (((yyGLRStackItem const *)yyvsp)[YYFILL (0)].yystate.yysemantics.yysval));
    }
#line 1752 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 94:
#line 655 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("i8");
    }
#line 1760 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 95:
#line 660 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("i16");
    }
#line 1768 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 96:
#line 665 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("i32");
    }
#line 1776 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 97:
#line 670 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("i64");
    }
#line 1784 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 98:
#line 675 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("u8");
    }
#line 1792 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 99:
#line 680 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("u16");
    }
#line 1800 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 100:
#line 685 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("u32");
    }
#line 1808 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 101:
#line 690 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("u64");
    }
#line 1816 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 102:
#line 695 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("f64");
    }
#line 1824 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 103:
#line 700 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("decimal");
    }
#line 1832 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 104:
#line 705 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("date");
    }
#line 1840 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 105:
#line 710 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("timeOfDayMilli");
    }
#line 1848 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 106:
#line 715 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("timeOfDayNano");
    }
#line 1856 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 107:
#line 720 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("nanoTime");
    }
#line 1864 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 108:
#line 725 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("milliTime");
    }
#line 1872 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 109:
#line 730 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("boolean");
    }
#line 1880 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 110:
#line 735 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("string");
    }
#line 1888 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 111:
#line 740 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("binary");
    }
#line 1896 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 112:
#line 745 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("fixed");
    }
#line 1904 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 113:
#line 750 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("object");
    }
#line 1912 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 114:
#line 755 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("namespace");
    }
#line 1920 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 115:
#line 760 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("type");
    }
#line 1928 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 116:
#line 765 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = rb_str_new2("schema");
    }
#line 1936 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;

  case 125:
#line 800 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:816  */
    {
        ((*yyvalp)) = Qnil;
    }
#line 1944 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
    break;


#line 1948 "ext/slow_blink/ext_schema_parser/parser.c" /* glr.c:816  */
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
  (!!((Yystate) == (-91)))

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



#line 805 "etc/slow_blink/ext_schema_parser/parser.y" /* glr.c:2584  */


void Init_ext_schema_parser(void)
{
    cSlowBlink = rb_define_module("SlowBlink");
    cParseError = rb_const_get(cSlowBlink, rb_intern("ParseError"));
    rb_define_singleton_method(cSlowBlink, "parse_file_buffer", parseFileBuffer, -1);
}

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg)
{
    VALUE message = newLocation(filename, locp);
    rb_str_append(message, rb_str_new2(" error: "));
    rb_str_append(message, rb_funcall(rb_str_new2(msg), rb_intern("sub"), 2, rb_str_new2("UNKNOWN"), rb_str_new2(yyget_text(scanner))));    
    rb_funcall(rb_stderr, rb_intern("puts"), 1, message);
}

static VALUE parseFileBuffer(int argc, VALUE* argv, VALUE self)
{
    yyscan_t scanner;    
    VALUE tree = Qnil;
    VALUE buffer;
    VALUE opts;
    VALUE filename;
    int retval = 0;

    rb_scan_args(argc, argv, "10:", &buffer, &opts);

    if(buffer == Qnil){
        rb_raise(rb_eTypeError, "error: input must be a string");
    }

    if(opts == Qnil){
        opts = rb_hash_new();
    }

    filename = rb_hash_aref(opts, ID2SYM(rb_intern("filename")));

    if(yylex_init(&scanner) == 0){

        if(yy_scan_bytes((const char *)RSTRING_PTR(buffer), RSTRING_LEN(buffer), scanner)){

            retval = yyparse(scanner, filename, &tree);
        }

        yylex_destroy(scanner);

        switch(retval){
        case 0:
            break;
        case 1:
        case 2:
            rb_raise(cParseError, "parse error");
            break;
        default:
            rb_bug("yyparse: unknown return code");
            break;
        }        
    }

    return tree;
}

static VALUE newLocation(VALUE filename, const YYLTYPE *locp)
{
    VALUE retval = rb_str_new2("");

    if(filename != Qnil){

        retval = filename;
        rb_str_append(retval, rb_str_new2(":"));
    }
    else{

        retval = rb_str_new2("");
    }

    rb_str_append(retval, rb_funcall(INT2NUM(locp->first_line), rb_intern("to_s"), 0));
    rb_str_append(retval, rb_str_new2(":"));
    rb_str_append(retval, rb_funcall(INT2NUM(locp->first_column), rb_intern("to_s"), 0));
    rb_str_append(retval, rb_str_new2(":"));

    return retval;
}
