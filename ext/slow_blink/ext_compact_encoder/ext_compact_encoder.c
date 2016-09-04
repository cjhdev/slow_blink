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


#define MIN8    -128L
#define MAX8    127L
#define MIN16   -32768L
#define MAX16   32767L
#define MIN32   -2147483648L
#define MAX32   2147483647L
#define MIN64   -9223372036854775808L
#define MAX64   9223372036854775807L
#define MAXU8   0xffUL
#define MAXU16  0xffffUL
#define MAXU32  0xffffffffUL
#define MAXU64  0xffffffffffffffffUL

/* static function prototypes *****************************************/

static VALUE putNull(VALUE self);

static VALUE putPresent(VALUE self, VALUE val);
static VALUE getPresent(VALUE self);

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

static VALUE getU8(VALUE self);
static VALUE getU16(VALUE self);
static VALUE getU32(VALUE self);
static VALUE getU64(VALUE self);
static VALUE getI8(VALUE self);
static VALUE getI16(VALUE self);
static VALUE getI32(VALUE self);
static VALUE getI64(VALUE self);
static VALUE getF64(VALUE self);
static VALUE getBool(VALUE self);

static VALUE getBinary(VALUE self);
static VALUE getString(VALUE self);
static VALUE getFixed(VALUE self, VALUE size);
static VALUE getFixedOptional(VALUE self, VALUE size);

static VALUE putInt(VALUE self, VALUE val, int64_t min, int64_t max, bool isSigned);
static VALUE getInt(VALUE input, int64_t min, int64_t max, bool isSigned);

/* static variables ***************************************************/

static VALUE cError;

/* functions **********************************************************/

void Init_ext_compact_encoder(void)
{
    VALUE cSlowBlink;

    cSlowBlink = rb_define_module("SlowBlink");
    cError = rb_const_get(cSlowBlink, rb_intern("Error"));
    
    rb_define_method(rb_cString, "putNull", putNull, 0);
    rb_define_method(rb_cString, "putPresent", putPresent, 0);
    rb_define_method(rb_cString, "getPresent", getPresent, 0);

    rb_define_method(rb_cString, "putU8", putU8, 1);
    rb_define_method(rb_cString, "putU16", putU16, 1);
    rb_define_method(rb_cString, "putU32", putU32, 1);
    rb_define_method(rb_cString, "putU64", putU64, 1);
    rb_define_method(rb_cString, "putI8", putI8, 1);
    rb_define_method(rb_cString, "putI16", putI16, 1);
    rb_define_method(rb_cString, "putI32", putI32, 1);
    rb_define_method(rb_cString, "putI64", putI64, 1);

    rb_define_method(rb_cString, "putF64", putF64, 1);

    rb_define_method(rb_cString, "putBool", putBool, 1);

    rb_define_method(rb_cString, "putString", putString, 1);
    rb_define_method(rb_cString, "putBinary", putBinary, 1);
    rb_define_method(rb_cString, "putFixed", putFixed, 1);
    rb_define_method(rb_cString, "putFixedOptional", putFixedOptional, 1);

    rb_define_method(rb_cString, "getU8!", getU8, 0);
    rb_define_method(rb_cString, "getU16!", getU16, 0);
    rb_define_method(rb_cString, "getU32!", getU32, 0);
    rb_define_method(rb_cString, "getU64!", getU64, 0);
    rb_define_method(rb_cString, "getI8!", getI8, 0);
    rb_define_method(rb_cString, "getI16!", getI16, 0);
    rb_define_method(rb_cString, "getI32!", getI32, 0);
    rb_define_method(rb_cString, "getI64!", getI64, 0);

    rb_define_method(rb_cString, "getF64!", getF64, 0);

    rb_define_method(rb_cString, "getBool!", getBool, 0);

    rb_define_method(rb_cString, "getString!", getString, 0);    
    rb_define_method(rb_cString, "getBinary!", getBinary, 0);    
    rb_define_method(rb_cString, "getFixed!", getFixed, 1);    
    rb_define_method(rb_cString, "getFixedOptional!", getFixedOptional, 1);    
}

/* static functions ***************************************************/

static VALUE putU8(VALUE self, VALUE val)
{
    return putInt(self, val, 0, MAXU8, false);
}
static VALUE putU16(VALUE self, VALUE val)
{
    return putInt(self, val, 0, MAXU16, false);
}
static VALUE putU32(VALUE self, VALUE val)
{
    return putInt(self, val, 0, MAXU32, false);
}
static VALUE putU64(VALUE self, VALUE val)
{
    return putInt(self, val, 0, MAXU64, false);
}
static VALUE putI8(VALUE self, VALUE val)
{
    return putInt(self, val, MIN8, MAX8, true);
}
static VALUE putI16(VALUE self, VALUE val)
{
    return putInt(self, val, MIN16, MAX16, true);
}
static VALUE putI32(VALUE self, VALUE val)
{
    return putInt(self, val, MIN32, MAX32, true);
}
static VALUE putI64(VALUE self, VALUE val)
{
    return putInt(self, val, MIN64, MAX64, true);
}
static VALUE putF64(VALUE self, VALUE val)
{    
    VALUE retval;
    uint8_t out[10U];

    if(val == Qnil){

        retval = putNull(self);
    }
    else{

        double value = NUM2DBL(val);
        retval = rb_str_buf_cat(self, (const char *)out, BLINK_putVLC(*((uint64_t *)(&value)), false, out, sizeof(out)));
    }

    return retval;
}

static VALUE putBool(VALUE self, VALUE val)
{
    VALUE retval;
    
    if(val == Qnil){

        retval = putNull(self);
    }
    else{
        
        retval = putU8(self, (val == Qfalse) ? INT2FIX(0) : INT2FIX(1));
    }

    return retval;        
}

static VALUE putNull(VALUE self)
{
    uint8_t str[] = {0xc0};
    return rb_str_buf_cat(self, (const char *)str, sizeof(str));
}

static VALUE putPresent(VALUE self, VALUE val)
{
    VALUE retval;
    
    if(val == Qfalse){

        retval = putNull(self);
    }
    else{

        uint8_t str[] = {0x1};
        retval = rb_str_buf_cat(self, (const char *)str, sizeof(str));
    }

    return retval;
}

static VALUE putBinary(VALUE self, VALUE val)
{
    VALUE retval;

    if(val == Qnil){

        retval = putNull(self);
    }
    else{

        retval = putU32(self, UINT2NUM(RSTRING_LEN(val)));
        retval = rb_str_concat(retval, val);        

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

        retval = putNull(self);    
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

static VALUE putInt(VALUE self, VALUE val, int64_t min, int64_t max, bool isSigned)
{
    uint8_t out[10U];
    VALUE retval;

    if(val == Qnil){

        retval = putNull(self);
    }
    else{

        if(isSigned){

            int64_t value = NUM2LL(val);

            if((value < min) || (value > max)){

                rb_raise(cError, "Input exceeds allowable range of type");
            }

            retval = rb_str_buf_cat(self, (const char *)out, BLINK_putVLC((uint64_t)value, true, out, sizeof(out)));
        }
        else{

            uint64_t value = NUM2ULL(val);

            if(value > (uint64_t)max){

                rb_raise(cError, "Input exceeds allowable range of type");
            }

            retval = rb_str_buf_cat(self, (const char *)out, BLINK_putVLC(value, false, out, sizeof(out)));
        }
    }

    return retval;
}

static VALUE getU8(VALUE self)
{
    return getInt(self, 0, MAXU8, false);
}

static VALUE getU16(VALUE self)
{
    return getInt(self, 0, MAXU16, false);
}

static VALUE getU32(VALUE self)
{
    return getInt(self, 0, MAXU32, false);
}

static VALUE getU64(VALUE self)
{
    return getInt(self, 0, MAXU64, false);
}

static VALUE getI8(VALUE self)
{
    return getInt(self, MIN8, MAX8, true);
}

static VALUE getI16(VALUE self)
{
    return getInt(self, MIN16, MAX16, true);
}

static VALUE getI32(VALUE self)
{
    return getInt(self, MIN32, MAX32, true);
}

static VALUE getI64(VALUE self)
{
    return getInt(self, MIN64, MAX64, true);
}

static VALUE getF64(VALUE self)
{
    bool isNull;
    double out;
    uint32_t ret;
    VALUE retval = Qnil;

    ret = BLINK_getVLC((const uint8_t *)RSTRING_PTR(self), RSTRING_LEN(self), false, (uint64_t *)&out, &isNull);

    if(ret > 0){

        rb_str_drop_bytes(self, ret);
        if(!isNull){

            retval = rb_float_new(out);
        }        
    }
    else{

        rb_raise(cError, "S1: Group encoding ends prematurely");
    }

    return retval;
}

static VALUE getPresent(VALUE self)
{
    VALUE retval = getInt(self, 0, 1, false);

    if(retval != Qnil){

        retval = Qtrue;
    }

    return retval;    
}

static VALUE getBool(VALUE self)
{
    VALUE retval;
    VALUE value = getInt(self, 0, MAXU8, false);

    if(value == UINT2NUM(0)){

        retval = Qfalse;
    }
    else if(value == UINT2NUM(1)){

        retval = Qtrue;
    }
    else{

        rb_raise(cError, "W11: Decoded value is not 0x00 or 0x01");
    }

    return retval;
}

static VALUE getBinary(VALUE self)
{
    VALUE retval = Qnil;
    VALUE size = getInt(self, 0, MAXU32, false);

    if(size != Qnil){

        if(NUM2UINT(size) > RSTRING_LEN(self)){
            rb_raise(cError, "S1: Group encoding ends prematurely");
        }

        retval = rb_str_substr(self, 0, NUM2UINT(size));
        rb_str_drop_bytes(self, NUM2UINT(size));
    }

    return retval;
}

static VALUE getString(VALUE self)
{
    VALUE retval = getBinary(self);

    if(retval != Qnil){

        //todo: test UTF8 encoding here
    }

    return retval;
}

static VALUE getFixed(VALUE self, VALUE size)
{
    VALUE retval;

    if(NUM2UINT(size) > RSTRING_LEN(self)){

        rb_raise(cError, "S1: Group encoding ends prematurely");
    }

    retval = rb_str_substr(self, 0, NUM2UINT(size));
    rb_str_drop_bytes(self, NUM2UINT(size));

    return retval;
}

static VALUE getFixedOptional(VALUE self, VALUE size)
{
    VALUE retval = Qnil;
    uint32_t ret;
    bool isNull;
    uint64_t present;

    ret = BLINK_getVLC((const uint8_t *)RSTRING_PTR(self), RSTRING_LEN(self), false, (uint64_t *)&present, &isNull);

    if(ret > 0){

        rb_str_drop_bytes(self, ret);

        if(isNull){

           retval = Qnil; 
        }
        else if(present == 0x01){

            retval = rb_str_substr(self, 0, NUM2UINT(size));

            if(RSTRING_LEN(retval) != NUM2UINT(size)){

                rb_raise(cError, "S1: Group encoding ends prematurely");
            }

            rb_str_drop_bytes(self, NUM2UINT(size));
        }
        else{

            rb_raise(cError, "W9: Presence flag is not 0xC0 or 0x01");
        }   
    }
    else{

        rb_raise(cError, "S1: Group encoding ends prematurely");
    }

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

                    rb_raise(cError, "W3: Decoded value overflows range");            
                }

                if(BLINK_getSizeSigned((int64_t)out) != ret){

                    rb_raise(cError, "W4: VLC entity contains more bytes than needed to express full width of type");
                }

                retval = LL2NUM((int64_t)out);
            }
            else{
                
                if(out > (uint64_t)max){

                    rb_raise(cError, "W3: Decoded value overflows range");            
                }

                if(BLINK_getSizeUnsigned(out) != ret){

                    rb_raise(cError, "W4: VLC entity contains more bytes than needed to express full width of type");
                }

                retval = ULL2NUM(out);
            }
        }        
    }
    else{

        rb_raise(cError, "S1: Group encoding ends prematurely");
    }

    return retval;
}
