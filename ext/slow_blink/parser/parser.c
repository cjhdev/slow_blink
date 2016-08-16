/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 2

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 6 "ext/slow_blink/parser/parser.y" /* yacc.c:339  */


/* includes ***********************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ruby.h>
#include <assert.h>

#include "lexer.h"

/* function prototypes ************************************************/

/**
 * - Mandatory yyerror function called by Flex/Bison
 * - variadic like printf
 *
 * @param[in] locp pointer to Bison location record
 * @param[in] scanner pointer to scanner instance (this is a pure parser)
 * @param[in] filename filename corresponding to location record
 * @param[out] tree the return structure
 * @param[in] msg printf format string
 *
 * */
void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg, ... );

/* static function prototypes *****************************************/

static VALUE parseFileBuffer(VALUE self, VALUE attr);
static VALUE newLocation(VALUE filename, YYLTYPE *location);

/* static variables ***************************************************/

static VALUE cSlowBlink;

static VALUE cLocation;

static VALUE cNameWithID;
static VALUE cCName;

static VALUE cSchema;
static VALUE cGroup;
static VALUE cField;
static VALUE cAnnotation;
static VALUE cIncrementalAnnotation;

static VALUE cDefinition;
static VALUE cEnumeration;
static VALUE cSym;

static VALUE cI8;
static VALUE cI16;
static VALUE cI32;
static VALUE cI64;
static VALUE cU8;
static VALUE cU16;
static VALUE cU32;
static VALUE cU64;
static VALUE cF64;
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

/* generated **********************************************************/


#line 151 "ext/slow_blink/parser/parser.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* In a future release of Bison, this section will be replaced
   by #include "parser.h".  */
#ifndef YY_YY_EXT_SLOW_BLINK_PARSER_PARSER_H_INCLUDED
# define YY_YY_EXT_SLOW_BLINK_PARSER_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOK_I8 = 258,
    TOK_I16 = 259,
    TOK_I32 = 260,
    TOK_I64 = 261,
    TOK_U8 = 262,
    TOK_U16 = 263,
    TOK_U32 = 264,
    TOK_U64 = 265,
    TOK_F64 = 266,
    TOK_DECIMAL = 267,
    TOK_DATE = 268,
    TOK_TIME_OF_DAY_MILLI = 269,
    TOK_TIME_OF_DAY_NANO = 270,
    TOK_NANO_TIME = 271,
    TOK_MILLI_TIME = 272,
    TOK_BOOLEAN = 273,
    TOK_STRING = 274,
    TOK_OBJECT = 275,
    TOK_NAMESPACE = 276,
    TOK_TYPE = 277,
    TOK_SCHEMA = 278,
    TOK_BINARY = 279,
    TOK_NUMBER = 280,
    TOK_FIXED = 281,
    TOK_LEFT_ARROW = 282,
    TOK_RIGHT_ARROW = 283,
    TOK_HEX = 284,
    TOK_UINT = 285,
    TOK_INT = 286,
    TOK_NC_NAME = 287,
    TOK_ESCAPED_NC_NAME = 288,
    TOK_LITERAL = 289
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef VALUE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif



int yyparse (yyscan_t scanner, VALUE filename, VALUE *tree);

#endif /* !YY_YY_EXT_SLOW_BLINK_PARSER_PARSER_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 250 "ext/slow_blink/parser/parser.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

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


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  10
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   226

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  48
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  47
/* YYNRULES -- Number of rules.  */
#define YYNRULES  121
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  159

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   302

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
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
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   137,   137,   144,   150,   158,   163,   170,   176,   182,
     186,   195,   203,   205,   212,   217,   224,   229,   236,   247,
     252,   259,   261,   265,   267,   269,   271,   273,   275,   277,
     282,   289,   296,   301,   308,   313,   320,   327,   334,   340,
     348,   353,   358,   363,   368,   373,   378,   383,   388,   393,
     400,   405,   410,   415,   420,   428,   433,   440,   445,   452,
     461,   463,   470,   475,   482,   490,   492,   499,   507,   509,
     516,   524,   530,   536,   542,   548,   556,   561,   569,   571,
     573,   575,   579,   581,   585,   587,   591,   596,   601,   606,
     611,   616,   621,   626,   631,   636,   641,   646,   651,   656,
     661,   666,   671,   676,   681,   686,   691,   696,   701,   708,
     716,   720,   722,   726,   733,   737,   739,   743,   745,   749,
     755,   759
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
  "\"number\"", "\"fixed\"", "\"<-\"", "\"->\"", "\"[0x][0-9a-fA-F]+\"",
  "\"[0-9]+\"", "\"[-][1-9][0-9]*\"", "\"[_a-zA-Z][_a-zA-Z0-9]*\"",
  "\"[\\\\][_a-zA-Z][_a-zA-Z0-9]*\"",
  "\"\\\"<annotation>\\\" or '<annotation>'\"", "\"=\"", "\":\"", "\",\"",
  "\"?\"", "\"[\"", "\"]\"", "\"(\"", "\")\"", "\"*\"", "\"|\"", "\"/\"",
  "\"@\"", "\".\"", "$accept", "top", "schema", "defs", "def", "define",
  "groupDef", "super", "body", "fields", "field", "opt", "type", "single",
  "sequence", "string", "binary", "fixed", "size", "ref", "number", "time",
  "enum", "syms", "sym", "val", "annots", "annot", "literal", "nameWithId",
  "id", "incrAnnot", "compRef", "incrAnnotList", "incrAnnotItem", "qName",
  "qNameOrKeyword", "keyword", "cName", "ncName", "name", "nsDecl",
  "literalSegment", "IntOrHex", "UintOrHex", "Definition", "e", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302
};
# endif

#define YYPACT_NINF -106

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-106)))

#define YYTABLE_NINF -122

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     -10,     9,    18,  -106,   -11,  -106,  -106,  -106,  -106,  -106,
    -106,  -106,    -7,  -106,   -16,  -106,    -1,   -27,  -106,     4,
    -106,  -106,   -11,   193,  -106,  -106,  -106,    12,   -31,   -21,
      -9,    15,  -106,  -106,  -106,  -106,  -106,  -106,  -106,  -106,
    -106,  -106,  -106,  -106,  -106,  -106,  -106,  -106,  -106,  -106,
    -106,  -106,  -106,  -106,  -106,  -106,    14,  -106,    11,    22,
    -106,  -106,     3,  -106,  -106,  -106,  -106,  -106,  -106,  -106,
      24,  -106,     5,  -106,  -106,     2,  -106,  -106,  -106,  -106,
      72,  -106,  -106,  -106,   -21,    31,  -106,     2,  -106,    17,
    -106,   149,  -106,  -106,  -106,  -106,  -106,  -106,  -106,  -106,
    -106,  -106,  -106,  -106,  -106,  -106,  -106,  -106,    16,  -106,
      16,    16,  -106,  -106,    23,  -106,  -106,  -106,  -106,  -106,
    -106,  -106,  -106,    19,  -106,   -16,    13,  -106,  -106,  -106,
    -106,  -106,  -106,     3,  -106,  -106,  -106,  -106,    25,  -106,
      10,  -106,  -106,   -16,    26,  -106,    20,     8,  -106,  -106,
      28,    27,  -106,  -106,  -106,  -106,  -106,  -106,  -106
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
     121,     0,     0,     2,     3,   121,     5,   111,   112,   113,
       1,    71,   111,     6,     0,     9,     0,    72,    83,     0,
      82,    62,     4,     0,     7,     8,    63,   121,   121,     0,
       0,     0,    86,    87,    88,    89,    90,    91,    92,    93,
      94,    95,    96,    97,    98,    99,   100,   101,   102,   105,
     106,   107,   108,   103,   104,    84,     0,    85,     0,   121,
      12,   121,     0,    67,    68,    80,    79,    78,    81,    70,
      76,    73,    74,   110,   109,     0,    13,   121,    11,    14,
       0,   118,   117,    69,     0,     0,   114,    64,    65,    15,
      16,     0,    40,    41,    42,    43,    44,    45,    46,    47,
      48,    49,    50,    51,    52,    53,    54,    29,    32,    30,
      34,     0,   121,   120,    21,    22,    26,    27,    28,    23,
      25,    24,   119,     0,    57,     0,    38,    10,    77,    75,
      66,   121,   121,     0,    33,    35,    36,    55,     0,   121,
     121,    39,    17,     0,     0,    31,    56,     0,    59,    60,
     121,   121,    37,   116,   115,    61,    20,    18,    19
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
    -106,  -106,  -106,    62,  -106,  -106,  -106,  -106,  -106,  -106,
     -62,  -106,   -18,  -106,  -106,  -106,  -106,  -106,   -65,  -106,
    -106,  -106,  -106,  -106,  -105,  -106,    -3,   -23,  -106,   -73,
    -106,  -106,  -106,    29,  -106,   -20,  -106,  -106,  -106,    63,
       1,  -106,     6,  -106,   -38,  -106,     0
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     3,     4,    13,    24,    25,    59,    78,    89,
      90,   157,   113,   114,   115,   116,   117,   118,   134,   119,
     120,   121,   122,   123,   124,   148,   125,    26,    87,    27,
      63,    15,    16,    69,    70,    17,    56,    57,    18,    19,
      20,     5,    88,   155,    83,   127,    21
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
       6,    14,     9,    55,    61,     6,    68,   137,    65,    66,
      67,     1,    11,    71,    62,    28,     7,     8,    10,    14,
      30,    12,     8,     7,     8,    23,    29,    60,    64,  -110,
      23,    72,    81,    82,   146,  -121,    86,   153,    76,   154,
      31,     7,     8,    12,     8,   135,   136,    73,    58,    75,
      77,    84,    85,   129,   131,   147,   141,   133,    80,    79,
     126,    68,   138,   139,   -58,   145,   156,    22,   152,   142,
     150,   126,    62,   132,    91,    92,    93,    94,    95,    96,
      97,    98,    99,   100,   101,   102,   103,   104,   105,   106,
     107,   108,   109,   130,    74,   144,   110,     0,   111,     0,
       0,     0,     0,     0,    12,     8,     0,     0,     0,     0,
       0,     0,     0,   128,     0,     0,   112,     0,    23,     0,
       0,     0,     0,     0,     0,     0,   140,     0,    91,   143,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     149,     0,     0,     0,   151,     0,     0,     0,     0,     0,
     158,    64,    92,    93,    94,    95,    96,    97,    98,    99,
     100,   101,   102,   103,   104,   105,   106,   107,   108,   109,
       0,     0,     0,   110,     0,   111,     0,     0,     0,     0,
       0,    12,     8,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    23,    32,    33,    34,    35,
      36,    37,    38,    39,    40,    41,    42,    43,    44,    45,
      46,    47,    48,    49,    50,    51,    52,    53,     0,    54,
       0,     0,     0,     0,     0,    12,     8
};

static const yytype_int16 yycheck[] =
{
       0,     4,     1,    23,    35,     5,    29,   112,    29,    30,
      31,    21,    23,    22,    45,    14,    32,    33,     0,    22,
      47,    32,    33,    32,    33,    46,    27,    27,    28,    36,
      46,    30,    29,    30,   139,    46,    34,    29,    58,    31,
      36,    32,    33,    32,    33,   110,   111,    32,    36,    35,
      28,    27,    47,    22,    37,    45,    43,    41,    61,    59,
      80,    84,    39,    44,    44,    40,    38,     5,    42,   131,
     143,    91,    45,    91,    77,     3,     4,     5,     6,     7,
       8,     9,    10,    11,    12,    13,    14,    15,    16,    17,
      18,    19,    20,    87,    31,   133,    24,    -1,    26,    -1,
      -1,    -1,    -1,    -1,    32,    33,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    84,    -1,    -1,    44,    -1,    46,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,   125,    -1,   131,   132,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     140,    -1,    -1,    -1,   143,    -1,    -1,    -1,    -1,    -1,
     150,   151,     3,     4,     5,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
      -1,    -1,    -1,    24,    -1,    26,    -1,    -1,    -1,    -1,
      -1,    32,    33,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    46,     3,     4,     5,     6,
       7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
      17,    18,    19,    20,    21,    22,    23,    24,    -1,    26,
      -1,    -1,    -1,    -1,    -1,    32,    33
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    21,    49,    50,    51,    89,    94,    32,    33,    88,
       0,    23,    32,    52,    74,    79,    80,    83,    86,    87,
      88,    94,    51,    46,    53,    54,    75,    77,    88,    27,
      47,    36,     3,     4,     5,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
      21,    22,    23,    24,    26,    83,    84,    85,    36,    55,
      94,    35,    45,    78,    94,    29,    30,    31,    75,    81,
      82,    22,    88,    32,    87,    35,    83,    28,    56,    94,
      74,    29,    30,    92,    27,    47,    34,    76,    90,    57,
      58,    74,     3,     4,     5,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,    16,    17,    18,    19,    20,
      24,    26,    44,    60,    61,    62,    63,    64,    65,    67,
      68,    69,    70,    71,    72,    74,    83,    93,    81,    22,
      90,    37,    60,    41,    66,    66,    66,    72,    39,    44,
      88,    43,    58,    74,    92,    40,    72,    45,    73,    94,
      77,    88,    42,    29,    31,    91,    38,    59,    94
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    48,    49,    50,    50,    51,    51,    52,    52,    52,
      53,    54,    55,    55,    56,    56,    57,    57,    58,    59,
      59,    60,    60,    61,    61,    61,    61,    61,    61,    61,
      61,    62,    63,    63,    64,    64,    65,    66,    67,    67,
      68,    68,    68,    68,    68,    68,    68,    68,    68,    68,
      69,    69,    69,    69,    69,    70,    70,    71,    71,    72,
      73,    73,    74,    74,    75,    76,    76,    77,    78,    78,
      79,    80,    80,    80,    80,    80,    81,    81,    82,    82,
      82,    82,    83,    83,    84,    84,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    86,
      87,    88,    88,    89,    90,    91,    91,    92,    92,    93,
      93,    94
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     2,     1,     2,     2,     2,     1,
       4,     3,     1,     2,     1,     2,     1,     3,     5,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     3,     1,     2,     1,     2,     2,     3,     1,     2,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     2,     3,     1,     3,     3,
       1,     2,     1,     2,     4,     1,     2,     2,     1,     2,
       3,     1,     1,     3,     3,     5,     1,     3,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     3,
       1,     1,     1,     2,     1,     1,     1,     1,     1,     1,
       1,     0
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (&yylloc, scanner, filename, tree, YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256


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

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


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


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, Location, scanner, filename, tree); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
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
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
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

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule, yyscan_t scanner, VALUE filename, VALUE *tree)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       , scanner, filename, tree);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule, scanner, filename, tree); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

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
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
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
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
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
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
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
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
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
  return 0;
}
#endif /* YYERROR_VERBOSE */

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




/*----------.
| yyparse.  |
`----------*/

int
yyparse (yyscan_t scanner, VALUE filename, VALUE *tree)
{
/* The lookahead symbol.  */
int yychar;


/* The semantic value of the lookahead symbol.  */
/* Default value used for initialization, for pacifying older GCCs
   or non-GCC compilers.  */
YY_INITIAL_VALUE (static YYSTYPE yyval_default;)
YYSTYPE yylval YY_INITIAL_VALUE (= yyval_default);

/* Location data for the lookahead symbol.  */
static YYLTYPE yyloc_default
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
YYLTYPE yylloc = yyloc_default;

    /* Number of syntax errors so far.  */
    int yynerrs;

    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.
       'yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  yylsp[0] = yylloc;
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yyls1, yysize * sizeof (*yylsp),
                    &yystacksize);

        yyls = yyls1;
        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
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

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 138 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        *tree = (yyvsp[0]);
    }
#line 1581 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 3:
#line 145 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {Qnil, (yyvsp[0])};        
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cSchema);            
    }
#line 1590 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 4:
#line 151 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-1]), (yyvsp[0])};        
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cSchema);            
    }
#line 1599 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 5:
#line 159 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new();
    }
#line 1607 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 6:
#line 164 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        rb_ary_push((yyval), (yyvsp[0]));
    }
#line 1615 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 7:
#line 171 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
        rb_funcall((yyval), rb_intern("annotate"), 1, (yyvsp[-1]));
    }
#line 1624 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 8:
#line 177 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
        rb_funcall((yyval), rb_intern("annotate"), 1, (yyvsp[-1]));
    }
#line 1633 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 10:
#line 187 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-3]), (yyvsp[0])};        
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cDefinition);
        rb_funcall((yyvsp[0]), rb_intern("annotate"), 1, (yyvsp[-1]));
    }
#line 1643 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 11:
#line 196 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-2]), (yyvsp[-1]), (yyvsp[0])};        
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);
    }
#line 1652 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 13:
#line 206 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
    }
#line 1660 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 14:
#line 213 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new();
    }
#line 1668 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 15:
#line 218 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
    }
#line 1676 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 16:
#line 225 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new_from_args(1, (yyvsp[0]));
    }
#line 1684 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 17:
#line 230 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        rb_ary_push((yyval), (yyvsp[0]));
    }
#line 1692 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 18:
#line 237 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-1]), (yyvsp[-3]), (yyvsp[0])};        
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);

        rb_funcall((yyval), rb_intern("annotate"), 1, (yyvsp[-4]));
        rb_funcall((yyvsp[-1]), rb_intern("annotate"), 1, (yyvsp[-2]));
    }
#line 1704 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 19:
#line 248 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = Qfalse;
    }
#line 1712 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 20:
#line 253 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = Qtrue;
    }
#line 1720 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 29:
#line 278 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cBOOLEAN);
    }
#line 1728 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 30:
#line 283 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cOBJECT);
    }
#line 1736 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 31:
#line 290 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(1, &(yyvsp[-2]), cSEQUENCE);
    }
#line 1744 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 32:
#line 297 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cSTRING);
    }
#line 1752 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 33:
#line 302 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(1, &(yyvsp[0]), cSTRING);
    }
#line 1760 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 34:
#line 309 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cBINARY);
    }
#line 1768 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 35:
#line 314 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(1, &(yyvsp[0]), cBINARY);
    }
#line 1776 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 36:
#line 321 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(1, &(yyvsp[0]), cFIXED);
    }
#line 1784 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 37:
#line 328 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[-1]);
    }
#line 1792 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 38:
#line 335 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[0]), Qfalse};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
#line 1801 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 39:
#line 341 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-1]), Qtrue};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
#line 1810 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 40:
#line 349 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cI8);
    }
#line 1818 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 41:
#line 354 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cI16);
    }
#line 1826 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 42:
#line 359 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cI32);
    }
#line 1834 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 43:
#line 364 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cI64);
    }
#line 1842 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 44:
#line 369 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cU8);
    }
#line 1850 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 45:
#line 374 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cU16);
    }
#line 1858 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 46:
#line 379 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cU32);
    }
#line 1866 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 47:
#line 384 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cU64);
    }
#line 1874 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 48:
#line 389 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cF64);
    }
#line 1882 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 49:
#line 394 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cDECIMAL);
    }
#line 1890 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 50:
#line 401 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cDATE);
    }
#line 1898 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 51:
#line 406 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cTIME_OF_DAY_MILLI);
    }
#line 1906 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 52:
#line 411 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cTIME_OF_DAY_NANO);
    }
#line 1914 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 53:
#line 416 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cNANO_TIME);
    }
#line 1922 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 54:
#line 421 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_class_new_instance(0, NULL, cMILLI_TIME);
    }
#line 1930 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 55:
#line 429 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new_from_args(1, (yyvsp[0]));
    }
#line 1938 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 56:
#line 434 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        rb_ary_push((yyval), (yyvsp[0]));
    }
#line 1946 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 57:
#line 441 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new_from_args(1, (yyvsp[0]));
    }
#line 1954 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 58:
#line 446 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        rb_ary_push((yyval), (yyvsp[0]));
    }
#line 1962 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 59:
#line 453 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-1]), (yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSym);
        rb_funcall((yyval), rb_intern("annotate"), 1, (yyvsp[-2]));
    }
#line 1972 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 61:
#line 464 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
    }
#line 1980 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 62:
#line 471 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new();
    }
#line 1988 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 63:
#line 476 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        rb_ary_push((yyval), (yyvsp[0]));
    }
#line 1996 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 64:
#line 483 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-2]), (yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cAnnotation);
    }
#line 2005 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 66:
#line 493 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        rb_str_append((yyval), (yyvsp[0]));
    }
#line 2013 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 67:
#line 500 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-1]), (yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cNameWithID);
    }
#line 2022 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 69:
#line 510 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
    }
#line 2030 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 70:
#line 517 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-2]), (yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cIncrementalAnnotation);
    }
#line 2039 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 71:
#line 525 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {cSchema};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSchemaRef);        
    }
#line 2048 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 72:
#line 531 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinitionRef);        
    }
#line 2057 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 73:
#line 537 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-2])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinitionTypeRef);        
    }
#line 2066 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 74:
#line 543 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-2]), (yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFieldRef);        
    }
#line 2075 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 75:
#line 549 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-4]), (yyvsp[-2])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFieldTypeRef);        
    }
#line 2084 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 76:
#line 557 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_ary_new_from_args(1, (yyvsp[0]));
    }
#line 2092 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 77:
#line 562 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
        rb_ary_unshift((yyval), (yyvsp[-2]));
    }
#line 2101 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 86:
#line 592 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("i8");
    }
#line 2109 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 87:
#line 597 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("i16");
    }
#line 2117 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 88:
#line 602 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("i32");
    }
#line 2125 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 89:
#line 607 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("i64");
    }
#line 2133 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 90:
#line 612 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("u8");
    }
#line 2141 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 91:
#line 617 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("u16");
    }
#line 2149 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 92:
#line 622 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("u32");
    }
#line 2157 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 93:
#line 627 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("u64");
    }
#line 2165 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 94:
#line 632 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("f64");
    }
#line 2173 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 95:
#line 637 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("decimal");
    }
#line 2181 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 96:
#line 642 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("date");
    }
#line 2189 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 97:
#line 647 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("timeOfDayMilli");
    }
#line 2197 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 98:
#line 652 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("timeOfDayNano");
    }
#line 2205 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 99:
#line 657 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("nanoTime");
    }
#line 2213 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 100:
#line 662 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("milliTime");
    }
#line 2221 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 101:
#line 667 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("boolean");
    }
#line 2229 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 102:
#line 672 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("string");
    }
#line 2237 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 103:
#line 677 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("binary");
    }
#line 2245 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 104:
#line 682 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("fixed");
    }
#line 2253 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 105:
#line 687 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("object");
    }
#line 2261 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 106:
#line 692 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("namespace");
    }
#line 2269 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 107:
#line 697 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("type");
    }
#line 2277 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 108:
#line 702 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = rb_str_new_cstr("schema");
    }
#line 2285 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 109:
#line 709 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[-2]), (yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cCName);
    }
#line 2294 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 113:
#line 727 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = (yyvsp[0]);
    }
#line 2302 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 119:
#line 750 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        VALUE args[] = {(yyvsp[0])};
        (yyval) = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cEnumeration);
    }
#line 2311 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;

  case 121:
#line 760 "ext/slow_blink/parser/parser.y" /* yacc.c:1646  */
    {
        (yyval) = Qnil;
    }
#line 2319 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
    break;


#line 2323 "ext/slow_blink/parser/parser.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (&yylloc, scanner, filename, tree, YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (&yylloc, scanner, filename, tree, yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc, scanner, filename, tree);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[1] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, yylsp, scanner, filename, tree);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (&yylloc, scanner, filename, tree, YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc, scanner, filename, tree);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp, yylsp, scanner, filename, tree);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 765 "ext/slow_blink/parser/parser.y" /* yacc.c:1906  */


/* functions **********************************************************/


void Init_parser(void)
{
    cSlowBlink = rb_define_module("SlowBlink");

    cLocation = rb_const_get(cSlowBlink, rb_intern("Location"));

    cNameWithID = rb_const_get(cSlowBlink, rb_intern("NameWithID"));
    cCName = rb_const_get(cSlowBlink, rb_intern("cCName"));
    
    cSchema = rb_const_get(cSlowBlink, rb_intern("Schema"));
    cGroup = rb_const_get(cSlowBlink, rb_intern("Group"));
    cField = rb_const_get(cSlowBlink, rb_intern("Field"));
    cDefinition = rb_const_get(cSlowBlink, rb_intern("Field"));

    cAnnotation = rb_const_get(cSlowBlink, rb_intern("Annotation"));
    cIncrementalAnnotation = rb_const_get(cSlowBlink, rb_intern("IncrementalAnnotation"));

    cDefinition = rb_const_get(cSlowBlink, rb_intern("Definition"));
    cEnumeration = rb_const_get(cSlowBlink, rb_intern("Enumeration"));
    cSym = rb_const_get(cSlowBlink, rb_intern("Sym"));

    cU8 = rb_const_get(cSlowBlink, rb_intern("U8"));
    cU16 = rb_const_get(cSlowBlink, rb_intern("U16"));
    cU32 = rb_const_get(cSlowBlink, rb_intern("U32"));
    cU64 = rb_const_get(cSlowBlink, rb_intern("U64"));
    cI8 = rb_const_get(cSlowBlink, rb_intern("I8"));
    cI16 = rb_const_get(cSlowBlink, rb_intern("I16"));
    cI32 = rb_const_get(cSlowBlink, rb_intern("I32"));
    cI64 = rb_const_get(cSlowBlink, rb_intern("I64"));
    cF64 = rb_const_get(cSlowBlink, rb_intern("F64"));
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
    
    rb_define_module_function(cSlowBlink, "parseFileBuffer", parseFileBuffer, 1);
}

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg, ... )
{
    int retval;
    VALUE rbString;
    char error[500];

    int hdrLen;
    
    hdrLen = snprintf(error, sizeof(error), "%s:%i:%i: error: ", (const char *)RSTRING_PTR(filename), locp->first_line, locp->first_column);

    if((hdrLen > 0) && (hdrLen <= sizeof(error))){

        va_list argptr;
        va_start(argptr, msg);
        retval = vsnprintf(&error[hdrLen], sizeof(error) - hdrLen, msg, argptr);
        va_end(argptr);

        if((retval > 0) && ((hdrLen + retval) <= sizeof(error))){

            rbString = rb_str_new((const char *)error, (hdrLen + retval));
            rb_io_puts(1, &rbString, rb_stderr);            
        }
        else{

            rb_bug("yyerror buffer is too short to contain error message");
        }
    }
    else{

        rb_bug("yyerror buffer is too short to contain error message");
    }
}

/* static functions ***************************************************/

static VALUE parseFileBuffer(VALUE self, VALUE attr)
{
    yyscan_t scanner;    

    VALUE tree = Qnil;

    VALUE buffer = rb_hash_aref(attr, ID2SYM(rb_intern("buffer")));
    VALUE filename = rb_hash_aref(attr, ID2SYM(rb_intern("fileName")));

    if(yylex_init(&scanner) == 0){

            if(yy_scan_bytes((const char *)RSTRING_PTR(buffer), RSTRING_LEN(buffer), scanner)){

            yyparse(scanner, filename, &tree);
        }

        yylex_destroy(scanner);
    }

    return tree;
}

static VALUE newLocation(VALUE filename, YYLTYPE *location)
{
    return rb_funcall(cLocation, rb_intern("new"), 5,
        filename,
        INT2NUM(location->first_line),
        INT2NUM(location->last_line),
        INT2NUM(location->first_column),
        INT2NUM(location->last_column)
    );    
}
