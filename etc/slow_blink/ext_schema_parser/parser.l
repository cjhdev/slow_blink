/* Blink Protocol Flex Configuration
 *
 * Cameron Harper 2016
 *
 * */
%{

#include <ruby.h>
#include "parser.h"

#define YY_USER_ACTION do{\
    yylloc->first_line = yylloc->last_line;\
    yylloc->first_column = yylloc->last_column;\
    yylloc->last_column += yyleng;\
}while(0);    

%}

%option nounput noinput noyywrap
%option bison-locations
%option fast
%option reentrant

%%

"#"[^\n]*           { }
[ \t]+              { }    
[\n]+               { yylloc->last_column = 0; yylloc->last_line += yyleng; }

["][^\n\"]*["]      |
['][^\n']*[']       { *yylval = rb_str_new(&yytext[1], yyleng-2); rb_ary_push(crefs, *yylval); return TOK_LITERAL; }

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

[0][x][0-9a-fA-F]+ { *yylval = rb_funcall(rb_str_new(yytext, yyleng), rb_intern("to_i"), 1, UINT2NUM(16U)); rb_ary_push(crefs, *yylval); return TOK_HEX; }
[0-9]+             { *yylval = rb_funcall(rb_str_new(yytext, yyleng), rb_intern("to_i"), 0); rb_ary_push(crefs, *yylval); return TOK_UINT; }
[-][1-9][0-9]*     { *yylval = rb_funcall(rb_str_new(yytext, yyleng), rb_intern("to_i"), 0); rb_ary_push(crefs, *yylval); return TOK_INT; }

[_a-zA-Z][_a-zA-Z0-9]*[:][_a-zA-Z][_a-zA-Z0-9]* { *yylval = rb_str_new(yytext, yyleng); rb_ary_push(crefs, *yylval); return TOK_C_NAME; }
[_a-zA-Z][_a-zA-Z0-9]*      { *yylval = rb_str_new(yytext, yyleng); rb_ary_push(crefs, *yylval); return TOK_NC_NAME; }
[\\][_a-zA-Z][_a-zA-Z0-9]*  { *yylval = rb_str_new(&yytext[1], yyleng-1); rb_ary_push(crefs, *yylval); return TOK_ESCAPED_NC_NAME; }

.                   { return TOK_UNKNOWN; }

%%
