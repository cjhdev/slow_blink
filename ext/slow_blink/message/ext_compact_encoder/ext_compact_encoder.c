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
#include <stddef.h>
#include <assert.h>

#include "blink_compact.h"
#include "blink_stream.h"

/* defines ************************************************************/

/* static function prototypes *****************************************/

static VALUE putNull(VALUE self);

static VALUE putPresent(VALUE self);
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

static bool myRead(void *state, void *buf, size_t nbyte);
static bool myWrite(void *state, const void *buf, size_t nbyte);

/* static variables ***************************************************/

static VALUE cStrongError1;

static VALUE cWeakError3;
static VALUE cWeakError4;
static VALUE cWeakError9;
static VALUE cWeakError11;

static const struct blink_stream_user cUserStream = {
    .read = myRead,
    .write = myWrite
};

/* functions **********************************************************/

void Init_ext_compact_encoder(void)
{
    VALUE cSlowBlink;
    VALUE cMessage;
    VALUE cStringIO;

    cSlowBlink = rb_define_module("SlowBlink");
    cMessage = rb_const_get(cSlowBlink, rb_intern("Message"));
    cStringIO = rb_const_get(rb_cObject, rb_intern("StringIO"));

    cStrongError1 = rb_const_get(cMessage, rb_intern("StrongError1"));

    cWeakError3 = rb_const_get(cMessage, rb_intern("WeakError3"));
    cWeakError4 = rb_const_get(cMessage, rb_intern("WeakError4"));
    cWeakError9 = rb_const_get(cMessage, rb_intern("WeakError9"));
    cWeakError11 = rb_const_get(cMessage, rb_intern("WeakError11"));
    
    rb_define_method(rb_cString, "putNull", putNull, 0);
    rb_define_method(rb_cString, "putPresent", putPresent, 0);
    rb_define_method(cStringIO, "getPresent", getPresent, 0);

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

    rb_define_method(cStringIO, "getU8", getU8, 0);
    rb_define_method(cStringIO, "getU16", getU16, 0);
    rb_define_method(cStringIO, "getU32", getU32, 0);
    rb_define_method(cStringIO, "getU64", getU64, 0);
    rb_define_method(cStringIO, "getI8", getI8, 0);
    rb_define_method(cStringIO, "getI16", getI16, 0);
    rb_define_method(cStringIO, "getI32", getI32, 0);
    rb_define_method(cStringIO, "getI64", getI64, 0);

    rb_define_method(cStringIO, "getF64", getF64, 0);

    rb_define_method(cStringIO, "getBool", getBool, 0);

    rb_define_method(cStringIO, "getString", getString, 0);    
    rb_define_method(cStringIO, "getBinary", getBinary, 0);    
    rb_define_method(cStringIO, "getFixed", getFixed, 1);    
}

/* static functions ***************************************************/

static bool myRead(void *state, void *buf, size_t nbyte)
{
    bool retval = false;
    
    VALUE stringIO = *(VALUE *)state;
    VALUE out = rb_funcall(stringIO, rb_intern("read"), 1, SIZET2NUM(nbyte));
    
    if((size_t)RSTRING_LEN(out) == nbyte){

        (void)memcpy(buf, RSTRING_PTR(out), (size_t)RSTRING_LEN(out));
        retval = true;
    }
    else{

        rb_raise(cStrongError1, "S1: Group encoding ends prematurely");
    }

    return retval;
}

static bool myWrite(void *state, const void *buf, size_t nbyte)
{
    return rb_str_buf_cat(*(VALUE *)state, buf, nbyte);    
}

static VALUE putU8(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
        if(NUM2ULL(val) <= UINT8_MAX){

            struct blink_stream stream;
            
            (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
            (void)BLINK_Compact_encodeU8((uint8_t)NUM2ULL(val), &stream);
        }
        else{

            rb_raise(rb_eRangeError, "Input exceeds allowable range of type");
        }
    }
    
    return self;
}
static VALUE putU16(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
        if(NUM2ULL(val) <= UINT16_MAX){

            struct blink_stream stream;
            
            (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
            (void)BLINK_Compact_encodeU16((uint16_t)NUM2ULL(val), &stream);
        }
        else{

            rb_raise(rb_eRangeError, "Input exceeds allowable range of type");
        }
    }
    
    return self;
}
static VALUE putU32(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
        if(NUM2ULL(val) <= UINT32_MAX){

            struct blink_stream stream;
            
            (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
            (void)BLINK_Compact_encodeU32((uint32_t)NUM2ULL(val), &stream);
        }
        else{

            rb_raise(rb_eRangeError, "Input exceeds allowable range of type");
        }
    }

    return self;
}
static VALUE putU64(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{

        struct blink_stream stream;
        
        (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
        (void)BLINK_Compact_encodeU64(NUM2ULL(val), &stream);        
    }
    
    return self;
}
static VALUE putI8(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
        if((NUM2LL(val) >= INT8_MIN) && (NUM2LL(val) <= INT8_MAX)){

            struct blink_stream stream;
            
            (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
            (void)BLINK_Compact_encodeI8((int8_t)NUM2LL(val), &stream);
        }
        else{

            rb_raise(rb_eRangeError, "Input exceeds allowable range of type");
        }
    }
    return self;
}
static VALUE putI16(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{

        if((NUM2LL(val) >= INT16_MIN) && (NUM2LL(val) <= INT16_MAX)){

            struct blink_stream stream;
            
            (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
            (void)BLINK_Compact_encodeI16((int16_t)NUM2LL(val), &stream);
        }
        else{

            rb_raise(rb_eRangeError, "Input exceeds allowable range of type");
        }
    }
    return self;
}
static VALUE putI32(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
        
        if((NUM2LL(val) >= INT32_MIN) && (NUM2LL(val) <= INT32_MAX)){

            struct blink_stream stream;
            
            (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
            (void)BLINK_Compact_encodeI32((int32_t)NUM2LL(val), &stream);
        }
        else{

            rb_raise(rb_eRangeError, "Input exceeds allowable range of type");
        }
    }
    return self;
}
static VALUE putI64(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{

        struct blink_stream stream;
        
        (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
        (void)BLINK_Compact_encodeI64(NUM2LL(val), &stream);        
    }
    return self;
}
static VALUE putF64(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
    
        struct blink_stream stream;
        
        (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
        (void)BLINK_Compact_encodeF64(NUM2DBL(val), &stream);
    }
    return self;
}

static VALUE putBool(VALUE self, VALUE val)
{
    if(val == Qnil){

        (void)putNull(self);
    }
    else{
        
        struct blink_stream stream;
        
        (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
        (void)BLINK_Compact_encodeBool(((val == Qfalse) ? false : true), &stream);
    }
    return self;
}

static VALUE putNull(VALUE self)
{
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    (void)BLINK_Compact_encodeNull(&stream);
    return self;    
}

static VALUE putPresent(VALUE self)
{
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    (void)BLINK_Compact_encodePresent(&stream);
    return self;
}

static VALUE putBinary(VALUE self, VALUE val)
{  
    VALUE retval = Qnil;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);

    if(val == Qnil){

        retval = putNull(self);
    }
    else{

        if(RSTRING_LEN(val) <= UINT32_MAX){
        
            (void)BLINK_Compact_encodeU32((uint32_t)RSTRING_LEN(val), &stream);
            retval = rb_str_buf_cat(self, RSTRING_PTR(val), RSTRING_LEN(val));                
        }
        else{

            rb_raise(rb_eRangeError, "String is too long");
        }
    }
    
    return retval;
}

static VALUE putString(VALUE self, VALUE val)
{
    //todo: enforce utf8 encoding
    return putBinary(self, val);
}

static VALUE putFixed(VALUE self, VALUE val)
{
    return rb_str_buf_cat(self, RSTRING_PTR(val), (size_t)RSTRING_LEN(val));
}

static VALUE getU8(VALUE self)
{
    VALUE retval = Qnil;
    uint8_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeU8(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : UINT2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getU16(VALUE self)
{
    VALUE retval = Qnil;
    uint16_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeU16(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : UINT2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getU32(VALUE self)
{
    VALUE retval = Qnil;
    uint32_t val;
    bool isNull;
    
    struct blink_stream stream;
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeU32(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : UINT2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getU64(VALUE self)
{
    VALUE retval = Qnil;
    uint64_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeU64(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : ULL2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getI8(VALUE self)
{
    VALUE retval = Qnil;
    int8_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeI8(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : INT2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getI16(VALUE self)
{
    VALUE retval = Qnil;
    int16_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeI16(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : INT2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getI32(VALUE self)
{
    VALUE retval = Qnil;
    int32_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeI32(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : INT2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getI64(VALUE self)
{
    VALUE retval = Qnil;
    int64_t val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeI64(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : LL2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getF64(VALUE self)
{
    VALUE retval = Qnil;
    double val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeF64(&stream, &val, &isNull)){

        retval = (isNull) ? Qnil : DBL2NUM(val);
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getPresent(VALUE self)
{
    VALUE retval = Qnil;
    bool val;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodePresent(&stream, &val)){

        retval = (val) ? Qtrue : Qfalse;
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
    }
        
    return retval;
}

static VALUE getBool(VALUE self)
{
    VALUE retval = Qnil;
    bool val;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);
    if(BLINK_Compact_decodeBool(&stream, &val, &isNull)){

        retval = (val) ? Qtrue : Qfalse;
    }
    else{

        rb_raise(cWeakError11, "out of range");
    }
        
    return retval;
}

static VALUE getBinary(VALUE self)
{
    VALUE retval = Qnil;
    uint32_t size;
    bool isNull;
    struct blink_stream stream;
    
    (void)BLINK_Stream_initUser(&stream, &self, cUserStream);

    if(BLINK_Compact_decodeU32(&stream, &size, &isNull)){

        if(!isNull){

            retval = rb_funcall(self, rb_intern("read"), 1, UINT2NUM(size));

            if((retval == Qnil) || ((uint32_t)NUM2UINT(rb_funcall(retval, rb_intern("size"), 0)) != size)){

                rb_raise(cStrongError1, "S1: Group encoding ends prematurely");
            }
        }
    }
    else{

        rb_raise(rb_eRangeError, "out of range");
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
    VALUE retval = rb_funcall(self, rb_intern("read"), 1, UINT2NUM(size));

    if((retval == Qnil) || ((uint32_t)NUM2UINT(rb_funcall(retval, rb_intern("size"), 0)) != NUM2UINT(size))){

        rb_raise(cStrongError1, "S1: Group encoding ends prematurely");
    }

    return retval;    
}
