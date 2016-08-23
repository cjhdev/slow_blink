/* Copyright (c) 2016 Cameron Harper
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * 
 * */

/* includes ***********************************************************/

#include <ruby.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>

#include "compact_encoder.h"

/* defines ************************************************************/


#define MIN8    0x80L
#define MAX8    0x7fL
#define MIN16   0x8000L
#define MAX16   0x7fffL
#define MIN32   0x80000000L
#define MAX32   0x7fffffffL
#define MIN64   0x8000000000000000L
#define MAX64   0x7fffffffffffffffL
#define MAXU8   0xffUL
#define MAXU16  0xffffUL
#define MAXU32  0xffffffffUL
#define MAXU64  0xffffffffffffffffUL


/* static function prototypes *****************************************/

static VALUE putNull(void);

static VALUE putU8(VALUE self, VALUE val);
static VALUE putU16(VALUE self, VALUE val);
static VALUE putU32(VALUE self, VALUE val);
static VALUE putU64(VALUE self, VALUE val);
static VALUE putI8(VALUE self, VALUE val);
static VALUE putI16(VALUE self, VALUE val);
static VALUE putI32(VALUE self, VALUE val);
static VALUE putI64(VALUE self, VALUE val);
static VALUE putF64(VALUE self, VALUE val);
static VALUE putBool(VALUE self, VALUE val);

static VALUE putBinary(VALUE self, VALUE val);
static VALUE putString(VALUE self, VALUE val);
static VALUE putFixed(VALUE self, VALUE val);
static VALUE putFixedOptional(VALUE self, VALUE val);

static VALUE getU8(VALUE self, VALUE input);
static VALUE getU16(VALUE self, VALUE input);
static VALUE getU32(VALUE self, VALUE input);
static VALUE getU64(VALUE self, VALUE input);
static VALUE getI8(VALUE self, VALUE input);
static VALUE getI16(VALUE self, VALUE input);
static VALUE getI32(VALUE self, VALUE input);
static VALUE getI64(VALUE self, VALUE input);
static VALUE getF64(VALUE self, VALUE input);
static VALUE getBool(VALUE self, VALUE input);

static VALUE getBinary(VALUE self, VALUE input);
static VALUE getString(VALUE self, VALUE input);
static VALUE getFixed(VALUE self, VALUE input, VALUE size);
static VALUE getFixedOptional(VALUE self, VALUE input, VALUE size);

static VALUE putInt(VALUE val, int64_t min, int64_t max, bool isSigned);
static VALUE getInt(VALUE input, int64_t min, int64_t max, bool isSigned);

/* static variables ***************************************************/

static VALUE cError;

/* functions **********************************************************/

void Init_ext_compact_encoder(void)
{
    VALUE cSlowBlink;
    VALUE cCompactEncoder;

    cSlowBlink = rb_define_module("SlowBlink");
    cError = rb_const_get(cSlowBlink, rb_intern("Error"));
    
    cCompactEncoder = rb_define_module_under(cSlowBlink, "CompactEncoder");

    rb_define_module_function(cCompactEncoder, "putU8", putU8, 1);
    rb_define_module_function(cCompactEncoder, "putU16", putU16, 1);
    rb_define_module_function(cCompactEncoder, "putU32", putU32, 1);
    rb_define_module_function(cCompactEncoder, "putU64", putU64, 1);
    rb_define_module_function(cCompactEncoder, "puti8", putI8, 1);
    rb_define_module_function(cCompactEncoder, "puti16", putI16, 1);
    rb_define_module_function(cCompactEncoder, "puti32", putI32, 1);
    rb_define_module_function(cCompactEncoder, "puti64", putI64, 1);

    rb_define_module_function(cCompactEncoder, "putF64", putF64, 1);

    rb_define_module_function(cCompactEncoder, "putBool", putBool, 1);

    rb_define_module_function(cCompactEncoder, "putString", putString, 1);
    rb_define_module_function(cCompactEncoder, "putBinary", putBinary, 1);
    rb_define_module_function(cCompactEncoder, "putFixed", putFixed, 1);
    rb_define_module_function(cCompactEncoder, "putFixedOptional", putFixedOptional, 1);

    rb_define_module_function(cCompactEncoder, "getU8", getU8, 1);
    rb_define_module_function(cCompactEncoder, "getU16", getU16, 1);
    rb_define_module_function(cCompactEncoder, "getU32", getU32, 1);
    rb_define_module_function(cCompactEncoder, "getU64", getU64, 1);
    rb_define_module_function(cCompactEncoder, "getI8", getI8, 1);
    rb_define_module_function(cCompactEncoder, "getI16", getI16, 1);
    rb_define_module_function(cCompactEncoder, "getI32", getI32, 1);
    rb_define_module_function(cCompactEncoder, "getI64", getI64, 1);

    rb_define_module_function(cCompactEncoder, "getF64", getF64, 1);

    rb_define_module_function(cCompactEncoder, "getBool", getBool, 1);

    rb_define_module_function(cCompactEncoder, "getString", getString, 1);    
    rb_define_module_function(cCompactEncoder, "getBinary", getBinary, 1);    
    rb_define_module_function(cCompactEncoder, "getFixed", getFixed, 2);    
    rb_define_module_function(cCompactEncoder, "getFixedOptional", getFixedOptional, 2);    
}

/* static functions ***************************************************/

static VALUE putU8(VALUE self, VALUE val)
{
    return putInt(val, 0, MAXU8, false);
}

static VALUE putU16(VALUE self, VALUE val)
{
    return putInt(val, 0, MAXU16, false);
}
static VALUE putU32(VALUE self, VALUE val)
{
    return putInt(val, 0, MAXU32, false);
}
static VALUE putU64(VALUE self, VALUE val)
{
    return putInt(val, 0, MAXU64, false);
}
static VALUE putI8(VALUE self, VALUE val)
{
    return putInt(val, MIN8, MAX8, true);
}
static VALUE putI16(VALUE self, VALUE val)
{
    return putInt(val, MIN16, MAX16, true);
}
static VALUE putI32(VALUE self, VALUE val)
{
    return putInt(val, MIN32, MAX32, true);
}
static VALUE putI64(VALUE self, VALUE val)
{
    return putInt(val, MIN64, MAX64, true);
}
static VALUE putF64(VALUE self, VALUE val)
{    
    VALUE retval;
    uint8_t out[10U];

    if(val == Qnil){

        retval = putNull();
    }
    else{

        double value = NUM2DBL(val);
        retval = rb_str_new((const char *)out, BLINK_putVLC(*((uint64_t *)(&value)), false, out, sizeof(out)));
    }

    return retval;
}

static VALUE putBool(VALUE self, VALUE val)
{
    VALUE retval;
    
    if(val == Qnil){

        retval = putNull();
    }
    else{
        
        retval = putU8(self, (val == Qfalse) ? INT2FIX(0) : INT2FIX(1));
    }

    return retval;        
}

static VALUE putNull(void)
{
    uint8_t str[] = {0xc0};
    return rb_str_new((const char *)str, sizeof(str));
}

static VALUE putBinary(VALUE self, VALUE val)
{
    VALUE retval;

    if(val == Qnil){

        retval = putNull();
    }
    else{

        retval = putU32(self, UINT2NUM(RSTRING_LEN(val)));
        rb_str_concat(retval, val);        
    }

    return retval;
}

static VALUE putString(VALUE self, VALUE val)
{
    //todo: enforce utf8 encoding
    return putBinary(self, val);
}

static VALUE putFixedOptional(VALUE self, VALUE val)
{
    VALUE retval;

    if(val == Qnil){

        retval = putNull();    
    }
    else{

        uint8_t str[] = {0x01};
        retval = rb_str_new((const char *)str, sizeof(str));
        rb_str_concat(retval, val);        
    }

    return retval;
}

static VALUE putFixed(VALUE self, VALUE val)
{
    return rb_str_dup(val);
}

static VALUE putInt(VALUE val, int64_t min, int64_t max, bool isSigned)
{
    uint8_t out[10U];
    VALUE retval;

    if(val == Qnil){

        retval = putNull();
    }
    else{

        if(isSigned){

            int64_t value = NUM2LL(val);

            if((value < min) || (value > max)){

                rb_raise(cError, "out of range");
            }

            retval = rb_str_new((const char *)out, BLINK_putVLC((uint64_t)value, false, out, sizeof(out)));
        }
        else{

            uint64_t value = NUM2ULL(val);

            if(value > (uint64_t)max){

                rb_raise(cError, "out of range");
            }

            retval = rb_str_new((const char *)out, BLINK_putVLC(value, false, out, sizeof(out)));
        }
    }

    return retval;
}

static VALUE getU8(VALUE self, VALUE input)
{
    return getInt(input, 0, MAXU8, false);
}

static VALUE getU16(VALUE self, VALUE input)
{
    return getInt(input, 0, MAXU16, false);
}

static VALUE getU32(VALUE self, VALUE input)
{
    return getInt(input, 0, MAXU32, false);
}

static VALUE getU64(VALUE self, VALUE input)
{
    return getInt(input, 0, MAXU64, false);
}

static VALUE getI8(VALUE self, VALUE input)
{
    return getInt(input, MIN8, MAX8, true);
}

static VALUE getI16(VALUE self, VALUE input)
{
    return getInt(input, MIN16, MAX16, true);
}

static VALUE getI32(VALUE self, VALUE input)
{
    return getInt(input, MIN32, MAX32, true);
}

static VALUE getI64(VALUE self, VALUE input)
{
    return getInt(input, MIN64, MAX64, true);
}

static VALUE getF64(VALUE self, VALUE input)
{
    bool isNull;
    double out;
    uint32_t ret;
    VALUE retval = Qnil;

    ret = BLINK_getVLC((const uint8_t *)RSTRING_PTR(input), RSTRING_LEN(input), false, (uint64_t *)&out, &isNull);

    if(ret > 0){

        rb_str_drop_bytes(input, ret);
        if(!isNull){

            retval = rb_float_new(out);
        }        
    }

    return retval;
}

static VALUE getBool(VALUE self, VALUE input)
{
    VALUE retval;
    VALUE value = getInt(input, 0, MAXU8, false);

    if(value == UINT2NUM(0)){

        retval = Qfalse;
    }
    else if(value == UINT2NUM(1)){

        retval = Qtrue;
    }
    else{

        rb_raise(cError, "W11");
    }

    return retval;
}

static VALUE getBinary(VALUE self, VALUE input)
{
    VALUE retval = Qnil;
    VALUE size = getInt(input, 0, MAXU32, false);

    if(size != Qnil){

        retval = rb_str_substr(input, 0, NUM2UINT(size));
        rb_str_drop_bytes(input, NUM2UINT(size));

        //todo: not sure how substr works if input is short
        assert(RSTRING_LEN(retval) == NUM2UINT(size));
    }

    return retval;
}

static VALUE getString(VALUE self, VALUE input)
{
    VALUE retval = getBinary(self, input);

    if(retval != Qnil){

        //todo: test UTF8 encoding here
    }

    return retval;
}

static VALUE getFixed(VALUE self, VALUE input, VALUE size)
{
    VALUE retval;

    retval = rb_str_substr(input, 0, NUM2UINT(size));

    assert(RSTRING_LEN(retval) == NUM2UINT(size));

    rb_str_drop_bytes(input, NUM2UINT(size));

    return retval;
}

static VALUE getFixedOptional(VALUE self, VALUE input, VALUE size)
{
    VALUE retval;

    retval = rb_str_substr(input, 0, NUM2UINT(size));

    assert(RSTRING_LEN(retval) == NUM2UINT(size));

    rb_str_drop_bytes(input, NUM2UINT(size));

    return retval;
}

static VALUE getInt(VALUE input, int64_t min, int64_t max, bool isSigned)
{
    bool isNull;
    uint64_t out;
    VALUE retval = Qnil;
    uint32_t ret;

    ret = BLINK_getVLC((const uint8_t *)RSTRING_PTR(input), RSTRING_LEN(input), isSigned, &out, &isNull);

    if(ret > 0){

        rb_str_drop_bytes(input, ret);

        if(!isNull){

            if(isSigned){

                if(((int64_t)out < min) || ((int64_t)out > max)){

                    rb_raise(cError, "W3");            
                }

                if(BLINK_getSizeSigned((int64_t)out) != ret){

                    rb_raise(cError, "W4");
                }

                retval = LL2NUM((int64_t)out);
            }
            else{

                if(out > (uint64_t)max){

                    rb_raise(cError, "W3");            
                }

                if(BLINK_getSizeUnsigned(out) != ret){

                    rb_raise(cError, "W4");
                }

                retval = ULL2NUM(out);
            }

        }        
    }
    else{

        rb_raise(cError, "eof");
    }

    return retval;
}


