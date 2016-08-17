/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Skeleton interface for Bison GLR parsers in C

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
