/* Blink Protocol Flex Configuration
 *
 * Cameron Harper 2016
 *
 * */
%{

/* includes ***********************************************************/

#include <float.h>
#include <ruby.h>
#include "parser.h"

/* static prototypes **************************************************/

/**
 * - Inserted into lexer as part of the YY_USER_ACTION macro
 * - 
 * 
 * @param[in] loc pointer to Bison location record
 * @param[in] text
 * @param[in] textLen length of text in bytes
 *
 * */
static void updateLocation(YYLTYPE *loc, const char *text, int textLen);

/* macros *************************************************************/

#define YY_USER_ACTION updateLocation(yylloc, yytext, yyleng);

/* generated **********************************************************/

%}

%top{

    #include "common.h"

}

%option nounput
%option noinput
%option bison-bridge bison-locations
%option reentrant
%option noyywrap
%option debug


%x LITERAL_C
%x LITERAL_A

%%

"#"[^\r\n]*        { /* skip comments */ }

"\""                { BEGIN(LITERAL_C); }
<LITERAL_C>[^\"]*   { *yylval = rb_str_new(yytext, yyleng); return TOK_LITERAL; }
<LITERAL_C>"\""     { BEGIN(INITIAL); }

"'"                 { BEGIN(LITERAL_A); }
<LITERAL_A>[^']*    { *yylval = rb_str_new(yytext, yyleng); return TOK_LITERAL; }
<LITERAL_A>"'"      { BEGIN(INITIAL); }

"="                 |
","                 |
"?"                 |
"["                 |
"]"                 |
"("                 |
")"                 |
"*"                 |
"|"                 |
"."                 |
"/"                 |
"@"                 |
":"                 { return *yytext; }

"i8"                { return TOK_I8; }  
"i16"               { return TOK_I16; }
"i32"               { return TOK_I32; }
"i64"               { return TOK_I64; }
"u8"                { return TOK_U8; }
"u16"               { return TOK_U16; }
"u32"               { return TOK_U32; }
"u64"               { return TOK_U64; }
"f64"               { return TOK_F64; }
"decimal"           { return TOK_DECIMAL; }
"date"              { return TOK_DATE; }
"timeOfDayMilli"    { return TOK_TIME_OF_DAY_MILLI; }
"timeOfDayNano"     { return TOK_TIME_OF_DAY_NANO; }
"nanotime"          { return TOK_NANO_TIME; }
"millitime"         { return TOK_MILLI_TIME; }
"bool"              { return TOK_BOOLEAN; }
"string"            { return TOK_STRING; }
"object"            { return TOK_OBJECT; }
"namespace"         { return TOK_NAMESPACE; }
"type"              { return TOK_TYPE; }
"schema"            { return TOK_SCHEMA; }
"fixed"             { return TOK_FIXED; }
"binary"            { return TOK_BINARY; }

"->"                { return TOK_RIGHT_ARROW; }
"<-"                { return TOK_LEFT_ARROW; }

[0][x][0-9a-fA-F]+      { unsigned int tmp = 0; sscanf(yytext, "%x", &tmp); *yylval = UINT2NUM(tmp); return TOK_HEX; }
[0-9]+                  { unsigned int tmp = 0; sscanf(yytext, "%u", &tmp); *yylval = UINT2NUM(tmp); return TOK_UINT; }
[-][1-9][0-9]*          { int tmp = 0; sscanf(yytext, "%i", &tmp); *yylval = INT2NUM(tmp); return TOK_INT; }

[_a-zA-Z][_a-zA-Z0-9]*[:][_a-zA-Z][_a-zA-Z0-9]* { *yylval = rb_str_new(yytext, yyleng); return TOK_C_NAME; }
[_a-zA-Z][_a-zA-Z0-9]*      { *yylval = rb_str_new(yytext, yyleng); return TOK_NC_NAME; }
[\\][_a-zA-Z][_a-zA-Z0-9]*  { *yylval = rb_str_new(yytext, yyleng); return TOK_ESCAPED_NC_NAME; }

.|\n                {}

%%

/* static functions ***************************************************/

static void updateLocation(YYLTYPE *loc, const char *text, int textLen)
{
    int i;

    loc->first_line = loc->last_line;
    loc->first_column = loc->last_column;

    for(i=0; i < textLen; i++){

        if(text[i] == '\n'){
        
            loc->last_line++;
            loc->last_column = 0;
        }
        else{
        
            loc->last_column++;
        }
    }
}
