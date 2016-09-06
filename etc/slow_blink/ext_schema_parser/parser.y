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

%}

%define api.value.type {VALUE}
%define api.pure
%locations
%lex-param {yyscan_t scanner}
%parse-param {yyscan_t scanner}{VALUE filename}{VALUE *tree}
%define parse.error verbose
%define api.token.prefix {TOK_}
%glr-parser
%debug

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
    HEX                 "hexnum"
    UINT                "uint"
    INT                 "int"
    NAME                "name"
    NC_NAME             "ncName"
    ESCAPED_NC_NAME     "\\ncName"
    C_NAME              "cName"
    LITERAL             "\"<annotation>\" or '<annotation>'"
    
    
%%    

top:
    namespace
    {
        *tree = $namespace;
    }
    ;

namespace:    
    defs
    {
        VALUE args[] = {filename, Qnil, $defs};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cNamespace);            
    }
    |
    nsDecl defs
    {
        VALUE args[] = {filename, $nsDecl, $defs};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cNamespace);            
    }
    ;

defs:
    e
    {
        $$ = rb_ary_new();
    }
    |
    defList
    ;

defList:
    def
    {
        $$ = rb_ary_new();
        rb_ary_push($$, $def);
    }
    |
    defList def
    {
        rb_ary_push($$, $def);
    }
    ;

def:
    annots define
    {
        $$ = $define;
        rb_funcall($$, rb_intern("annote"), 1, $annots);
    }
    |
    annots groupDef
    {
        $$ = $groupDef;
        rb_funcall($$, rb_intern("annote"), 1, $annots);
    }
    |
    incrAnnot    
    ;

define:
    nameWithId '=' enum
    {
        VALUE enumArgs[] = {$enum};        
        VALUE args[] = {$nameWithId, rb_class_new_instance(sizeof(enumArgs)/sizeof(*enumArgs),enumArgs, cENUMERATION), newLocation(filename, &@$)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinition);        
    }
    |
    nameWithId '=' type
    {
        VALUE args[] = {$nameWithId, $type, newLocation(filename, &@$)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cDefinition);        
    }
    ;

groupDef:
    nameWithId
    {
        VALUE args[] = {$nameWithId, Qnil, rb_ary_new(), newLocation(filename, &@$)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    |
    nameWithId ':' qName
    {
        VALUE refArgs[] = {$qName, Qfalse, newLocation(filename, &@qName)};
        VALUE ref = rb_class_new_instance(sizeof(refArgs)/sizeof(*refArgs),refArgs, cREF);
        VALUE args[] = {$nameWithId, ref, rb_ary_new(), newLocation(filename, &@$)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    |
    nameWithId ':' qName RIGHT_ARROW fields
    {
        VALUE refArgs[] = {$qName, Qfalse, newLocation(filename, &@qName)};
        VALUE ref = rb_class_new_instance(sizeof(refArgs)/sizeof(*refArgs),refArgs, cREF);
        VALUE args[] = {$nameWithId, ref, $fields, newLocation(filename, &@$)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    |
    nameWithId RIGHT_ARROW fields
    {
        VALUE args[] = {$nameWithId, Qnil, $fields, newLocation(filename, &@$)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cGroup);
    }
    ;

fields:
    field
    {
        $$ = rb_ary_new();
        rb_ary_push($$, $field);        
    }
    |
    fields ',' field
    {
        rb_ary_push($$, $field);
    }
    ;

field:
    annots[typeAnnot] type annots[nameAnnot] nameWithId opt
    {
        VALUE args[] = {$nameWithId, $type, $opt, newLocation(filename, &@type)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);

        rb_funcall($$, rb_intern("annote"), 1, $typeAnnot);
        rb_funcall($nameWithId, rb_intern("annote"), 1, $nameAnnot);
    }
    ;

opt:
    e
    {
        $$ = Qfalse;
    }
    |
    '?'
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
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBOOLEAN);
    }
    |
    OBJECT
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cOBJECT);
    }
    ;

sequence:
    single '[' ']'
    {
        VALUE args[] = {$single, newLocation(filename, &@single)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSEQUENCE);
    }
    ;

string:
    STRING
    {
        VALUE args[] = {Qnil, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSTRING);
    }
    |
    STRING size
    {
        VALUE args[] = {$size, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSTRING);
    }
    ;

binary:
    BINARY
    {
        VALUE args[] = {Qnil, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBINARY);
    }
    |
    BINARY size
    {
        VALUE args[] = {$size, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBINARY);
    }
    ;

fixed:
    FIXED size
    {
        VALUE args[] = {$size, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFIXED);
    }
    ;

size:
    '(' uInt ')'
    {
        $$ = $uInt;
    }
    |
    '(' hexNum ')'
    {
        $$ = $hexNum;
    }
    ;

ref:
    qName
    {
        VALUE args[] = {$qName, Qfalse, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
    |
    qName '*'
    {
        VALUE args[] = {$qName, Qtrue, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
    ;

number:
    I8
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI8);
    }
    |
    I16
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI16);
    }
    |
    I32
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI32);
    }
    |
    I64
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cI64);
    }
    |
    U8
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU8);
    }
    |
    U16
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU16);
    }
    |
    U32
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU32);
    }
    |
    U64
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cU64);
    }
    |
    F64
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFLOATING_POINT);
    }
    |
    DECIMAL
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDECIMAL);
    }
    ;

time:
    DATE
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDATE);
    }
    |
    TIME_OF_DAY_MILLI
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cTIME_OF_DAY_MILLI);
    }
    |
    TIME_OF_DAY_NANO
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cTIME_OF_DAY_NANO);
    }
    |
    NANO_TIME
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cNANO_TIME);
    }
    |
    MILLI_TIME
    {
        VALUE args[] = {newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cMILLI_TIME);
    }
    ;

/* note: a single entry enum does in fact lead with a '|' */
enum:
    '|' sym
    {
        $$ = rb_ary_new();
        rb_ary_push($$, $sym);
    }
    |
    symList '|' sym
    {
        rb_ary_push($$, $sym);
    }
    ;

symList:
    sym
    {
        $$ = rb_ary_new();
        rb_ary_push($$, $sym);
    }
    |
    symList '|' sym
    {
        rb_ary_push($$, $sym);
    }
    ;

sym:
    annots name val
    {
        VALUE args[] = {$name, $val, newLocation(filename, &@name)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSym);
        rb_funcall($$, rb_intern("annote"), 1, $annots);        
    }
    ;
    
val:
    e
    |
    '/' int
    {
        $$ = $int;
    }
    |
    '/' hexNum
    {
        $$ = $hexNum;
    }
    ;

annots:
    e
    {
        $$ = rb_ary_new();
    }
    |
    annotList
    ;

annotList:
    annot
    {
        $$ = rb_ary_new();
        rb_ary_push($$, $annot);        
    }
    |
    annotList annot
    {
        rb_ary_push($$, $annot);
    }

annot:
    '@' qNameOrKeyword '=' literal
    {
        VALUE args[] = {$qNameOrKeyword, $literal, newLocation(filename, &@qNameOrKeyword)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cAnnotation);
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
    '/' uInt
    {
        $$ = $uInt;
    }
    |
    '/' hexNum
    {
        $$ = $hexNum;
    }
    ;

incrAnnot:
    compRef incrAnnotList
    {
        VALUE args[] = {$compRef, $incrAnnotList, newLocation(filename, &@$)};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cIncrementalAnnotation);
    }
    ;

compRef:
    SCHEMA
    {
        $$ = rb_class_new_instance(0, NULL, cSchemaRef);        
    }
    |
    qName
    {
        VALUE args[] = {$qName};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinitionRef);        
    }
    |
    qName '.' TYPE
    {
        VALUE args[] = {$qName};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cDefinitionTypeRef);        
    }
    |
    qName '.' name
    {
        VALUE args[] = {$qName, $name};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFieldRef);        
    }
    |
    qName '.' name '.' TYPE
    {
        VALUE args[] = {$qName, $name};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFieldTypeRef);        
    }
    ;

incrAnnotList:
    LEFT_ARROW incrAnnotItem
    {
        $$ = rb_ary_new();
        rb_ary_push($$, $incrAnnotItem);
    }
    |
    incrAnnotList LEFT_ARROW incrAnnotItem 
    {
        rb_ary_push($$, $incrAnnotItem);
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
        $$ = rb_str_new2("i8");
    }
    |
    I16
    {
        $$ = rb_str_new2("i16");
    }
    |
    I32
    {
        $$ = rb_str_new2("i32");
    }
    |
    I64
    {
        $$ = rb_str_new2("i64");
    }
    |
    U8
    {
        $$ = rb_str_new2("u8");
    }
    |
    U16
    {
        $$ = rb_str_new2("u16");
    }
    |
    U32
    {
        $$ = rb_str_new2("u32");
    }
    |
    U64
    {
        $$ = rb_str_new2("u64");
    }
    |
    F64
    {
        $$ = rb_str_new2("f64");
    }
    |
    DECIMAL
    {
        $$ = rb_str_new2("decimal");
    }
    |
    DATE
    {
        $$ = rb_str_new2("date");
    }
    |
    TIME_OF_DAY_MILLI
    {
        $$ = rb_str_new2("timeOfDayMilli");
    }
    |
    TIME_OF_DAY_NANO
    {
        $$ = rb_str_new2("timeOfDayNano");
    }
    |
    NANO_TIME
    {
        $$ = rb_str_new2("nanoTime");
    }
    |
    MILLI_TIME
    {
        $$ = rb_str_new2("milliTime");
    }
    |
    BOOLEAN
    {
        $$ = rb_str_new2("boolean");
    }
    |
    STRING
    {
        $$ = rb_str_new2("string");
    }
    |
    BINARY
    {
        $$ = rb_str_new2("binary");
    }
    |
    FIXED
    {
        $$ = rb_str_new2("fixed");
    }
    |
    OBJECT
    {
        $$ = rb_str_new2("object");
    }
    |
    NAMESPACE
    {
        $$ = rb_str_new2("namespace");
    }
    |
    TYPE
    {
        $$ = rb_str_new2("type");
    }
    |
    SCHEMA
    {
        $$ = rb_str_new2("schema");
    }
    ;    

cName:
    C_NAME
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

int:
    INT
    |
    UINT
    ;

uInt:
    UINT
    ;

hexNum:
    HEX
    ;

e:
    %empty
    {
        $$ = Qnil;
    }   
    ;

%%

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
