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

#include "compact_encoder.h"

/* functions **********************************************************/

uint8_t BLINK_putNull(uint8_t *out, uint32_t outMax)
{
    uint8_t retval = 0U;

    if(outMax > 0){

        *out = 0xC0U;
        retval = 1U;
    }

    return retval;
}

uint8_t BLINK_getSizeUnsigned(uint64_t value)
{
    uint8_t retval;

    if(value <= 0x7fUL){
        retval = 1U;
    }
    else if(value <= 0x3fffUL){
        retval = 2U;            
    }
    else if(value <= 0xffffUL){
        retval = 3U;
    }
    else if(value < 0xffffffUL){
        retval = 4U;
    }
    else if(value < 0xffffffffUL){
        retval = 5U;
    }
    else if(value < 0xffffffffffUL){
        retval = 6U;
    }
    else if(value < 0xffffffffffffUL){
        retval = 7U;
    }
    else if(value < 0xffffffffffffffUL){
        retval = 8U;
    }
    else{
        retval = 9U;
    }

    return retval;
}

uint8_t BLINK_getSizeSigned(int64_t value)
{
    uint8_t retval;

    if(value < 0){

        if(value > 0x40L){
            retval = 1U;
        }
        else if(value > 0x2000L){
            retval = 2U;
        }
        else if(value > 0x8000L){
            retval = 3U;
        }
        else if(value > 0x800000L){
            retval = 4U;
        }
        else if(value > 0x80000000L){
            retval = 5U;
        }
        else if(value > 0x8000000000L){
            retval = 6U;
        }
        else if(value > 0x800000000000L){
            retval = 7U;    
        }
        else if(value > 0x80000000000000L){
            retval = 8U;    
        }
        else{
            retval = 9U;    
        }
    }
    else{

        if(value <= 0x3fL){
            retval = 1U;
        }
        else if(value <= 0x1fffL){
            retval = 2U;            
        }
        else if(value <= 0x7fffL){
            retval = 3U;
        }
        else if(value < 0x7fffffffL){
            retval = 4U;
        }
        else if(value < 0x7fffffffffL){
            retval = 5U;
        }
        else if(value < 0x7fffffffffffL){
            retval = 6U;
        }
        else if(value < 0x7fffffffffffffL){
            retval = 7U;
        }
        else if(value < 0x7fffffffffffffffL){
            retval = 8U;
        }
        else{
            retval = 9U;
        }
    }

    return retval;
}

uint8_t BLINK_putVLC(uint64_t in, bool isSigned, uint8_t *out, uint32_t outMax)
{
    uint8_t bytes = (isSigned) ? BLINK_getSizeSigned((int64_t)in) : BLINK_getSizeUnsigned(in);
    uint8_t retval = 0U;
    uint8_t i;

    if(outMax >= bytes){

        if(bytes == 1){
            *out = (uint8_t)in;
        }
        else if(bytes == 2){
            out[1] = ((uint8_t)(in >> 6)) & 0x3f | 0x80;
            out[0] = ((uint8_t)in) & 0x3f;            
        }
        else{
            out[0] = 0xC0U | bytes;
            for(i=1; i < bytes; i++){
                out[i] = (uint8_t)(in >> ((i-1)*8));
            }            
        }
        retval = bytes;
    }

    return retval;
}

uint8_t BLINK_getVLC(const uint8_t *in, uint32_t inLen, bool isSigned, uint64_t *out, bool *isNull)
{
    uint8_t retval = 0U;
    uint8_t bytes;
    uint8_t i;

    *isNull = false;

    if(inLen > 0){

        if(*in < 0xc0){

            if(*in < 0x80){

                if(isSigned && ((*in & 0x40) == 0x40)){

                    *out = 0xffffffffffffffc0;
                }
                else{
                    
                    *out = 0x0;
                }
                *out |= (uint64_t)(*in & 0x7f);
                retval = 1U;  
            }
            else{

                if(inLen >= 2){
                    
                    if(isSigned && ((in[1] & 0x80) == 0x80)){

                        *out = 0xffffffffffffff00;            
                    }
                    else{
                        
                        *out = 0x0;
                    }
                    *out |= (uint64_t)in[1];
                    *out <<= 6;
                    *out |= (uint64_t)(in[0] & 0x3fU);
                    retval = 2U;
                }
            }
        }
        else if(*in == 0xc0){

            *isNull = true;
            retval = 1U;
        }
        else{

            if(inLen > 2U){
                
                bytes = *in & 0x3fU;

                if(bytes <= 8U){

                    if(isSigned && ((in[bytes] & 0x80U) == 0x80U)){
                        
                        *out = 0xffffffffffff00U;
                    }
                    
                    if(inLen >= (1U + bytes)){
                        
                        for(i=bytes; (i+1U) > 0U; i--){

                            *out |= in[i];
                            *out <<= 8;                
                        }

                        retval = bytes + 1U;
                    }
                }                
            }
        }
    }

    return retval;
}



    
