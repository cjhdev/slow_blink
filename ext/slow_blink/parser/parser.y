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

%}

%define api.value.type {VALUE}
%define api.pure
%locations
%lex-param {yyscan_t scanner}
%parse-param {yyscan_t scanner}{VALUE filename}{VALUE *tree}
%define parse.error verbose
%define api.token.prefix {TOK_}
%glr-parser

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
    NC_NAME             "cname"
    ESCAPED_NC_NAME     "\\cname"
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
        VALUE args[] = {Qnil, $defs};        
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
    defList
    ;

defList:
    def
    {
        $$ = rb_ary_new_from_args(1, $def);
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
    nameWithId '=' enum
    {
        VALUE enumArgs[] = {$enum};        
        VALUE args[] = {$nameWithId, rb_class_new_instance(sizeof(enumArgs)/sizeof(*enumArgs),enumArgs, cEnumeration)};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cDefinition);        
    }
    |
    nameWithId '=' type
    {
        VALUE args[] = {$nameWithId, $type};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cDefinition);        
    }
    ;

groupDef:
    nameWithId
    {
        VALUE args[] = {$nameWithId, Qnil, rb_ary_new()};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    |
    nameWithId ':' qName
    {
        VALUE refArgs[] = {$qName, Qfalse};
        VALUE args[] = {$nameWithId, rb_class_new_instance(sizeof(refArgs)/sizeof(*refArgs),refArgs, cREF), rb_ary_new()};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    |
    nameWithId ':' qName RIGHT_ARROW fields
    {
        VALUE refArgs[] = {$qName, Qfalse};
        VALUE args[] = {$nameWithId, rb_class_new_instance(sizeof(refArgs)/sizeof(*refArgs),refArgs, cREF), $fields};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    |
    nameWithId RIGHT_ARROW fields
    {
        VALUE args[] = {$nameWithId, Qnil, $fields};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cGroup);
    }
    ;

fields:
    field
    {
        $$ = rb_ary_new_from_args(1, $field);
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
        VALUE args[] = {$nameWithId, $type, $opt};        
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args),args, cField);

        rb_funcall($$, rb_intern("annotate"), 1, $typeAnnot);
        rb_funcall($nameWithId, rb_intern("annotate"), 1, $nameAnnot);
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
        $$ = rb_class_new_instance(0, NULL, cBOOLEAN);
    }
    |
    OBJECT
    {
        $$ = rb_class_new_instance(0, NULL, cOBJECT);
    }
    ;

sequence:
    single '[' ']'
    {
        $$ = rb_class_new_instance(1, &$single, cSEQUENCE);
    }
    ;

string:
    STRING
    {
        VALUE args[] = {Qnil};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSTRING);
    }
    |
    STRING size
    {
        VALUE args[] = {$size};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSTRING);
    }
    ;

binary:
    BINARY
    {
        VALUE args[] = {Qnil};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBINARY);
    }
    |
    BINARY size
    {
        VALUE args[] = {$size};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cBINARY);
    }
    ;

fixed:
    FIXED size
    {
        VALUE args[] = {$size};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cFIXED);
    }
    ;

size:
    '(' UintOrHex ')'
    {
        $$ = $UintOrHex;
    }   
    ;

ref:
    qName
    {
        VALUE args[] = {$qName, Qfalse};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
    }
    |
    qName '*'
    {
        VALUE args[] = {$qName, Qtrue};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cREF);    
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
    '|' sym
    {
        $$ = rb_ary_new_from_args(1, $sym);
    }
    |
    symList
    ;

symList:
    sym
    {
        $$ = rb_ary_new_from_args(1, $sym);
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
        VALUE args[] = {$name, $val};
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSym);
        rb_funcall($$, rb_intern("annotate"), 1, $annots);
        
    }
    ;
    
val:
    e
    |
    '/' AnyInt
    {
        $$ = $AnyInt;
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
        $$ = rb_ary_new_from_args(1, $annot);
    }
    |
    annotList annot
    {
        rb_ary_push($$, $annot);
    }

annot:
    '@' qNameOrKeyword '=' literal
    {
        VALUE args[] = {$qNameOrKeyword, $literal};
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
    '/' UintOrHex
    {
        $$ = $UintOrHex;
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
        $$ = rb_class_new_instance(sizeof(args)/sizeof(*args), args, cSchemaRef);        
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
        $$ = rb_str_new_cstr("i8");
    }
    |
    I16
    {
        $$ = rb_str_new_cstr("i16");
    }
    |
    I32
    {
        $$ = rb_str_new_cstr("i32");
    }
    |
    I64
    {
        $$ = rb_str_new_cstr("i64");
    }
    |
    U8
    {
        $$ = rb_str_new_cstr("u8");
    }
    |
    U16
    {
        $$ = rb_str_new_cstr("u16");
    }
    |
    U32
    {
        $$ = rb_str_new_cstr("u32");
    }
    |
    U64
    {
        $$ = rb_str_new_cstr("u64");
    }
    |
    F64
    {
        $$ = rb_str_new_cstr("f64");
    }
    |
    DECIMAL
    {
        $$ = rb_str_new_cstr("decimal");
    }
    |
    DATE
    {
        $$ = rb_str_new_cstr("date");
    }
    |
    TIME_OF_DAY_MILLI
    {
        $$ = rb_str_new_cstr("timeOfDayMilli");
    }
    |
    TIME_OF_DAY_NANO
    {
        $$ = rb_str_new_cstr("timeOfDayNano");
    }
    |
    NANO_TIME
    {
        $$ = rb_str_new_cstr("nanoTime");
    }
    |
    MILLI_TIME
    {
        $$ = rb_str_new_cstr("milliTime");
    }
    |
    BOOLEAN
    {
        $$ = rb_str_new_cstr("boolean");
    }
    |
    STRING
    {
        $$ = rb_str_new_cstr("string");
    }
    |
    BINARY
    {
        $$ = rb_str_new_cstr("binary");
    }
    |
    FIXED
    {
        $$ = rb_str_new_cstr("fixed");
    }
    |
    OBJECT
    {
        $$ = rb_str_new_cstr("object");
    }
    |
    NAMESPACE
    {
        $$ = rb_str_new_cstr("namespace");
    }
    |
    TYPE
    {
        $$ = rb_str_new_cstr("type");
    }
    |
    SCHEMA
    {
        $$ = rb_str_new_cstr("schema");
    }
    ;    

cName:
    ncName[namespace] ':' ncName[name]
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

AnyInt:
    INT
    |
    HEX
    |
    UINT
    ;

UintOrHex:
    UINT
    |
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


void Init_parser(void)
{
    cSlowBlink = rb_define_module("SlowBlink");

    cLocation = rb_const_get(cSlowBlink, rb_intern("Location"));

    cNameWithID = rb_const_get(cSlowBlink, rb_intern("NameWithID"));
    cCName = rb_const_get(cSlowBlink, rb_intern("CName"));
    
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
