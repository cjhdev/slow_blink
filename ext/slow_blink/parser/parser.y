/* Blink Protocol Bison Configuration
 *
 * Cameron Harper 2016
 * 
 * */
%{

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

static VALUE cSchema;
static VALUE cGroup;
static VALUE cAnnotation;

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

static VALUE cIncrementalAnnotation;


/* generated **********************************************************/

%}

%define api.value.type {VALUE}
%define api.pure full
%locations
%lex-param {yyscan_t scanner}
%parse-param {yyscan_t scanner}{VALUE filename}{VALUE *tree}
%define parse.error verbose

%define api.token.prefix {TOK_}

%token
    I8                  "i8"
    I16                 "i16"
    I32                 "i32"
    I64                 "i64"
    U8                  "u8"
    U16                 "u16"
    U32                 "u32"
    U64                 "u64"
    F64                 "f64"
    DECIMAL             "decimal"
    DATE                "date"
    TIME_OF_DAY_MILLI   "timeOfDayMilli"
    TIME_OF_DAY_NANO    "timeOfDayNano"
    NANO_TIME           "nanotime"
    MILLI_TIME          "millitime"
    BOOLEAN             "boolean"
    STRING              "string"
    OBJECT              "object" 
    NAMESPACE           "namespace"
    TYPE                "type" 
    SCHEMA              "schema"
    BINARY              "binary"
    NUMBER              "number"
    FIXED               "fixed"
    LEFT_ARROW          "<-"
    RIGHT_ARROW         "->"
    HEX                 "[0x][0-9a-fA-F]+"
    UINT                "[0-9]+"
    INT                 "[-][1-9][0-9]*"
    NC_NAME             "[_a-zA-Z][_a-zA-Z0-9]*"
    ESCAPED_NC_NAME     "[\\][_a-zA-Z][_a-zA-Z0-9]*"
    LITERAL             "\"<annotation>\" or '<annotation>'"
    
%%    

top:
    schema
    {
        *tree = $schema;
    }
    ;

schema:    
    defs
    {
        VALUE args[] = {nil, $defs};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cSchema);            
    }
    |
    nsDecl defs
    {
        VALUE args[] = {$nsDecl, $defs};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cSchema);            
    }
    ;
    
defs:
    e
    {
        $$ = rb_ary_new();
    }
    |
    defs def
    {
        rb_ary_push($$, $def);
    }
    ;

def:
    annots define
    {
        $$ = $define;
        rb_funcall($$, rb_intern("annotate"), 1, $annots);
    }
    |
    annots groupDef
    {
        $$ = $groupDef;
        rb_funcall($$, rb_intern("annotate"), 1, $annots);
    }
    |
    incrAnnot    
    ;

define:
    nameWithId "=" annots Definition
    {
        VALUE args[] = {$nameWithId, $Definition};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cDefinition);
        rb_funcall($$, rb_intern("annotate"), 1, $annots);
    }
    ;

groupDef:
    nameWithId super body
    {
        VALUE args[] = {$nameWithId, $super, $body};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);
    }
    ;

super:
    e
    |
    ":" qName
    {
        $$ = $qName;
    }
    ;

body:
    e
    {
        $$ = rb_ary_new();
    }
    |
    RIGHT_ARROW fields
    {
        $$ = $fields;
    }
    ;

fields:
    field
    {
        $$ = rb_ary_new_from_args(1, $field);
    }
    |
    fields "," field
    {
        rb_ary_push($$, $field);
    }
    ;

field:
    annots type annots nameWithId opt
    {
        VALUE args[] = {$nameWithId, $type, $opt};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);    
    }
    ;

opt:
    e
    {
        $$ = Qfalse;
    }
    |
    "?"
    {
        $$ = Qtrue;
    }
    ;

type:
    single
    |
    sequence
    ;

single:
    ref
    |
    time
    |
    number
    |
    string
    |
    binary
    |
    fixed
    |
    BOOLEAN
    {
        $$ = rb_class_new_instance(0, NULL, cBOOLEAN);
    }
    |
    OBJECT
    {
        $$ = rb_class_new_instance(0, NULL, cOBJECT);
    }
    ;

sequence:
    single "[" "]"
    {
        $$ = rb_class_new_instance(1, &$single, cSEQUENCE);
    }
    ;

string:
    STRING
    {
        $$ = rb_class_new_instance(0, NULL, cSTRING);
    }
    |
    STRING size
    {
        $$ = rb_class_new_instance(1, &$size, cSTRING);
    }
    ;

binary:
    BINARY
    {
        $$ = rb_class_new_instance(0, NULL, cBINARY);
    }
    |
    BINARY size
    {
        $$ = rb_class_new_instance(1, &$size, cBINARY);
    }
    ;

fixed:
    FIXED size
    {
        $$ = rb_class_new_instance(1, &$size, cFIXED);
    }
    ;

size:
    "(" UintOrHex ")"
    {
        $$ = $UintOrHex;
    }   
    ;

ref:
    qName
    {
        $$ = rb_class_new_instance(1, &$qName, cSubGroup);    
    }
    |
    qName "*"
    {
        $$ = rb_class_new_instance(1, &$qName, cDynamicSubGroup);    
    }
    ;

number:
    I8
    {
        $$ = rb_class_new_instance(0, NULL, cI8);
    }
    |
    I16
    {
        $$ = rb_class_new_instance(0, NULL, cI16);
    }
    |
    I32
    {
        $$ = rb_class_new_instance(0, NULL, cI32);
    }
    |
    I64
    {
        $$ = rb_class_new_instance(0, NULL, cI64);
    }
    |
    U8
    {
        $$ = rb_class_new_instance(0, NULL, cU8);
    }
    |
    U16
    {
        $$ = rb_class_new_instance(0, NULL, cU16);
    }
    |
    U32
    {
        $$ = rb_class_new_instance(0, NULL, cU32);
    }
    |
    U64
    {
        $$ = rb_class_new_instance(0, NULL, cU64);
    }
    |
    F64
    {
        $$ = rb_class_new_instance(0, NULL, cF64);
    }
    |
    DECIMAL
    {
        $$ = rb_class_new_instance(0, NULL, cDECIMAL);
    }
    ;

time:
    DATE
    {
        $$ = rb_class_new_instance(0, NULL, cDATE);
    }
    |
    TIME_OF_DAY_MILLI
    {
        $$ = rb_class_new_instance(0, NULL, cTIME_OF_DAY_MILLI);
    }
    |
    TIME_OF_DAY_NANO
    {
        $$ = rb_class_new_instance(0, NULL, cTIME_OF_DAY_NANO);
    }
    |
    NANO_TIME
    {
        $$ = rb_class_new_instance(0, NULL, cNANO_TIME);
    }
    |
    MILLI_TIME
    {
        $$ = rb_class_new_instance(0, NULL, cMILLI_TIME);
    }
    ;

/* note: a single entry enum does in fact lead with a '|' */
enum:
    "|" sym
    {
        $$ = rb_ary_new_from_args(1, $sym);
    }
    |
    syms "|" sym
    {
        rb_ary_push($$, $sym);
    }
    ;

syms:
    sym
    {
        $$ = rb_ary_new_from_args(1, $sym);
    }
    |
    syms "|" sym
    {
        rb_ary_push($$, $sym);
    }
    ;

sym:
    annots name val
    {
        VALUE args[] = {$name, $val};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSYM);
        rb_funcall($$, rb_intern("annotate"), 1, $annots);
    }
    ;
    
val:
    e
    |
    "/" IntOrHex
    {
        $$ = $IntOrHex;
    }
    ;

annots:
    e
    {
        $$ = rb_ary_new();
    }
    |
    annots annot
    {
        rb_ary_push($$, $annot);
    }
    ;

annot:
    "@" qNameOrKeyword "=" literal
    {
        VALUE args[] = {$qNameOrKeyword, $literal};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, Annotation);
    }
    ;

literal:
    literalSegment        
    |
    literal literalSegment
    {
        rb_str_append($$, $literalSegment);
    }
    ;

nameWithId:
    name id
    {
        VALUE args[] = {$name, $id};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cNameWithID);
    }
    ;

id:
    e
    |
    "/" UintOrHex
    {
        $UintOrHex;
    }
    ;

incrAnnot:
    compRef LEFT_ARROW incrAnnotList
    {
        VALUE args[] = {$compRef, $incrAnnotList};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cIncrementalAnnotation);
    }
    ;

compRef:
    SCHEMA
    {
        VALUE args[] = {cSchema};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cComponentReference);        
    }
    |
    qName
    {
        VALUE args[] = {qName};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cComponentReference);        
    }
    |
    qName "." TYPE
    {
        VALUE args[] = {qName};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cComponentReference);        
    }
    |
    qName "." name
    {
        VALUE args[] = {qName};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cComponentReference);        
    }
    |
    qName "." name "." TYPE
    {
        VALUE args[] = {qName, name, };
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cComponentReference);        
    }
    ;

incrAnnotList:
    incrAnnotItem
    {
        $$ = rb_ary_new_from_args(1, $incrAnnotItem);
    }
    |
    incrAnnotItem LEFT_ARROW incrAnnotList[list]
    {
        $$ = $list;
        rb_ary_unshift($$, $incrAnnotItem);
    }
    ;

incrAnnotItem:
    INT
    |
    UINT
    |
    HEX
    |
    annot
    ;

qName:
    name
    |
    cName
    ;

qNameOrKeyword:
    qName
    |
    keyword
    ;

keyword:
    I8
    {
        $$ = cI8;
    }
    |
    I16
    {
        $$ = cI16;
    }
    |
    I32
    {
        $$ = cI32;
    }
    |
    I64
    {
        $$ = cI64;
    }
    |
    U8
    {
        $$ = cU8;
    }
    |
    U16
    {
        $$ = cU16;
    }
    |
    U32
    {
        $$ = cU32;
    }
    |
    U64
    {
        $$ = cU64;
    }
    |
    F64
    {
        $$ = cF8;
    }
    |
    DECIMAL
    {
        $$ = cDECIMAL;
    }
    |
    DATE
    {
        $$ = cDATE;
    }
    |
    TIME_OF_DAY_MILLI
    {
        $$ = cTIME_OF_DAY_MILLI;
    }
    |
    TIME_OF_DAY_NANO
    {
        $$ = cTIME_OF_DAY_NANO;
    }
    |
    NANO_TIME
    {
        $$ = cNANO_TIME;
    }
    |
    MILLI_TIME
    {
        $$ = cMILLI_TIME;
    }
    |
    BOOLEAN
    {
        $$ = cBOOLEAN;
    }
    |
    STRING
    {
        $$ = cSTRING;
    }
    |
    BINARY
    {
        $$ = cBINARY;
    }
    |
    FIXED
    {
        $$ = cFIXED;
    }
    |
    OBJECT
    {
        $$ = cOBJECT;
    }
    |
    NAMESPACE
    {
        $$ = cNameSpace;
    }
    |
    TYPE
    {
        $$ = cType;
    }
    |
    SCHEMA
    {
        $$ = cSchema;
    }
    ;    

cName:
    ncName[namespace] ":" ncName[name]
    {
        VALUE args[] = {$namespace, $name};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cCName);
    }
    ;

ncName:
    NC_NAME
    ;

name:
    NC_NAME
    |
    ESCAPED_NC_NAME
    ;

nsDecl:
    NAMESPACE name
    {
        $$ = $name;
    }
    ;

literalSegment:
    LITERAL
    ;

IntOrHex:
    INT
    |
    HEX
    ;

UintOrHex:
    UINT
    |
    HEX
    ;
    
Definition:
    enum
    |
    type
    ;

e:
    %empty
    {
        $$ = Qnil;
    }   
    ;

%%

/* functions **********************************************************/


void Init_parser(void)
{
    cSlowBlink = rb_define_module("SlowBlink");

    cLocation = rb_const_get(cSlowBlink, rb_intern("Location"));

    cSchema = rb_const_get(cSlowBlink, rb_intern("Schema"));
    cGroup = rb_const_get(cSlowBlink, rb_intern("Group"));

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
    cOBJECT = rb_const_get(cSlowBlink, rb_intern("OBJECT"));
    
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