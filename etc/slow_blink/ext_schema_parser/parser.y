/* Blink Protocol Bison Configuration
 *
 * Cameron Harper 2016
 * 
 * */
%{

typedef void * yyscan_t;
#define YY_TYPEDEF_YY_SCANNER_T

#include <ruby.h>

#include "parser.h"
#include "lexer.h"

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg);

static VALUE parseFileBuffer(VALUE self, VALUE buffer, VALUE filename);
static VALUE newLocation(VALUE filename, const YYLTYPE *locp);

static VALUE cSlowBlink;
static VALUE cParseError;

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
    EOF     0
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
    UNKNOWN
    
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
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("defs")), $defs); 
    }
    |
    nsDecl defs
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("defs")), $defs); 
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $nsDecl); 
    }
    ;

nsDecl:
    NAMESPACE name
    {
        $$ = $name;
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
        rb_hash_aset($$, ID2SYM(rb_intern("annotes")), $annots);
    }
    |
    annots groupDef
    {
        $$ = $groupDef;        
        rb_hash_aset($$, ID2SYM(rb_intern("annotes")), $annots);
    }
    |
    incrAnnot    
    ;

define:
    nameWithId[name] '=' enumOrType
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("Definition")));
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("type")), $enumOrType);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

enumOrType:
    enum
    |
    type
    ;

groupDef:
    nameWithId[name] super body
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("Group")));
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("super")), $super);
        rb_hash_aset($$, ID2SYM(rb_intern("fields")), $body);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

super:
    e
    |
    ':' qName
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@qName));
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
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
    annots[typeAnnotes] type annots[nameAnnotes] nameWithId[name] opt
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("Field")));
        rb_hash_aset($type, ID2SYM(rb_intern("annotes")), $typeAnnotes);
        rb_hash_aset($$, ID2SYM(rb_intern("type")), $type);
        rb_hash_aset($$, ID2SYM(rb_intern("annotes")), $nameAnnotes);
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("optional")), $opt);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));        
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
    {
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("REF")));
    }
    |
    time
    |
    number
    |
    string
    {
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("STRING")));
    }
    |
    binary
    {
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("BINARY")));
    }
    |
    fixed
    |
    BOOLEAN
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("BOOLEAN")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    OBJECT
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("OBJECT")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

sequence:
    single '[' ']'
    {
        rb_hash_aset($$, ID2SYM(rb_intern("sequence")), Qtrue);
    }
    ;

string:
    STRING
    {
        $$ = rb_hash_new();        
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    STRING size
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
        rb_hash_aset($$, ID2SYM(rb_intern("size")), $size);
    }
    ;

binary:
    BINARY
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    BINARY size
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("size")), $size);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

fixed:
    FIXED size
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("FIXED")));
        rb_hash_aset($$, ID2SYM(rb_intern("size")), $size);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));        
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
        $$ = rb_hash_new();        
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    qName '*'
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
        rb_hash_aset($$, ID2SYM(rb_intern("dynamic")), Qtrue);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

number:
    I8
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I8")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    I16
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I16")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    I32
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I32")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    I64
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("I64")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    U8
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U8")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    U16
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U16")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    U32
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U32")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    U64
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("U64")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    F64
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("FLOATING_POINT")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    DECIMAL
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("DECIMAL")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

time:
    DATE
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("DATE")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    TIME_OF_DAY_MILLI
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("TIME_OF_DAY_MILLI")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    TIME_OF_DAY_NANO
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("TIME_OF_DAY_NANO")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    NANO_TIME
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("NANO_TIME")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    MILLI_TIME
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("MILLI_TIME")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

/* note: a single entry enum does in fact lead with a '|' */
enum:
    '|' sym
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("ENUM")));
        rb_hash_aset($$, ID2SYM(rb_intern("syms")), rb_ary_new());
        rb_ary_push(rb_hash_aref($$, ID2SYM(rb_intern("syms"))), $sym);
    }
    |
    symList '|' sym
    {
        rb_ary_push(rb_hash_aref($$, ID2SYM(rb_intern("syms"))), $sym);
    }
    ;

symList:
    sym
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("ENUM")));
        rb_hash_aset($$, ID2SYM(rb_intern("syms")), rb_ary_new());
        rb_ary_push(rb_hash_aref($$, ID2SYM(rb_intern("syms"))), $sym);
    }
    |
    symList '|' sym
    {
        rb_ary_push(rb_hash_aref($$, ID2SYM(rb_intern("syms"))), $sym);
    }
    ;

sym:
    annots name val
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("annotes")), $annots);
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("value")), $val);        
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
    '@' qNameOrKeyword[key] '=' literal[value]
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, $key, $value);    
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
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("id")), $id);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
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
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("class")), ID2SYM(rb_intern("IncrementalAnnotation")));
        rb_hash_aset($$, ID2SYM(rb_intern("annotes")), $incrAnnotList);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    ;

compRef:
    SCHEMA
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), ID2SYM(rb_intern("SCHEMA")));
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    qName
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    qName '.' TYPE
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
        rb_hash_aset($$, ID2SYM(rb_intern("type")), Qtrue);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    qName '.' name
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
    }
    |
    qName '.' name '.' TYPE
    {
        $$ = rb_hash_new();
        rb_hash_aset($$, ID2SYM(rb_intern("ref")), $qName);
        rb_hash_aset($$, ID2SYM(rb_intern("type")), Qtrue);
        rb_hash_aset($$, ID2SYM(rb_intern("name")), $name);
        rb_hash_aset($$, ID2SYM(rb_intern("loc")), newLocation(filename, &@$));
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

void Init_ext_schema_parser(void)
{
    cSlowBlink = rb_define_module("SlowBlink");
    cParseError = rb_const_get(cSlowBlink, rb_intern("ParseError"));
    rb_define_singleton_method(cSlowBlink, "parse_file_buffer", parseFileBuffer, 2);
}

void yyerror(YYLTYPE *locp, yyscan_t scanner, VALUE filename, VALUE *tree, char const *msg)
{
    VALUE message = newLocation(filename, locp);
    rb_str_append(message, rb_str_new2(" error: "));
    rb_str_append(message, rb_funcall(rb_str_new2(msg), rb_intern("sub"), 2, rb_str_new2("UNKNOWN"), rb_str_new2(yyget_text(scanner))));    
    rb_funcall(rb_stderr, rb_intern("puts"), 1, message);
}

static VALUE parseFileBuffer(VALUE self, VALUE buffer, VALUE filename)
{
    yyscan_t scanner;    
    VALUE tree = Qnil;
    int retval = 0;

    rb_gc_mark(filename);

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
