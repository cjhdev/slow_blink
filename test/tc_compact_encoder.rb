# Copyright (c) 2016 Cameron Harper
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#  
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "test/unit"
require 'slow_blink'

class TestCompactEncoder < Test::Unit::TestCase

    include SlowBlink

    def test_putU8
        input = 0x7f
        output = CompactEncoder::putU8(input)
        assert_equal("\x7f".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU8_big
        input = 0x80
        output = CompactEncoder::putU8(input)
        assert_equal("\x80\x02".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU8_tooBig
        input = 0x100
        assert_raise do
            CompactEncoder::putU8(input)
        end
    end

    def test_putU8_null
        input = nil
        output = CompactEncoder::putU8(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU16_small
        input = 0xff
        output = CompactEncoder::putU16(input)
        assert_equal("\xbf\x03".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU16
        input = 0xffff
        output = CompactEncoder::putU16(input)
        assert_equal("\xC2\xff\xff".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putU8_64unsigned
        input = 64
        output = CompactEncoder::putU8(input)
        assert_equal("\x40".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI8_64signed
        input = 64
        output = CompactEncoder::putI8(input)
        assert_equal("\x80\x01".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putU16_4711unsigned
        input = 4711
        output = CompactEncoder::putU16(input)
        assert_equal("\xa7\x49".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putU32_4294967295unsigned
        input = 4294967295
        output = CompactEncoder::putU32(input)
        assert_equal("\xc4\xff\xff\xff\xff".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI8_minus64
        input = -64
        output = CompactEncoder::putI8(input)
        assert_equal("\x40".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI16_minus4711
        input = -4711
        output = CompactEncoder::putI16(input)
        assert_equal("\x99\xb6".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI32_minus2147483648
        input = -2147483648
        output = CompactEncoder::putI32(input)
        assert_equal("\xc4\x00\x00\x00\x80".force_encoding("ASCII-8BIT"), output)
    end

    def test_putFixed
        input = "hello world"
        output = CompactEncoder::putFixed(input)
        assert_equal("hello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putFixedOptional
        input = "hello world"
        output = CompactEncoder::putFixedOptional(input)
        assert_equal("\x01hello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putFixedOptional_null
        input = nil
        output = CompactEncoder::putFixedOptional(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putString
        input = "hello world"
        output = CompactEncoder::putString(input)
        assert_equal("\x0bhello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putString_null
        input = nil
        output = CompactEncoder::putString(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBinary
        input = "hello world"
        output = CompactEncoder::putBinary(input)
        assert_equal("\x0bhello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBinary_null
        input = nil
        output = CompactEncoder::putBinary(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBool_true
        input = true
        output = CompactEncoder::putBool(input)
        assert_equal("\x01".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBool_false
        input = false
        output = CompactEncoder::putBool(input)
        assert_equal("\x00".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBool_nil
        input = nil
        output = CompactEncoder::putBool(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putF64
        input = nil
        output = CompactEncoder::putF64(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_getU8_64unsigned
        input = "\x40"
        output = CompactEncoder::getU8!(input)
        assert_equal(64, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI8_64signed
        input = "\x80\x01"
        output = CompactEncoder::getI8!(input)
        assert_equal(64, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getU16_4711unsigned
        input = "\xa7\x49"
        output = CompactEncoder::getU16!(input)
        assert_equal(4711, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getU32_4294967295unsigned
        input = "\xc4\xff\xff\xff\xff"
        output = CompactEncoder::getU32!(input)
        assert_equal(4294967295, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI8_minus64
        input = "\x40"
        output = CompactEncoder::getI8!(input)
        assert_equal(-64, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI16_minus4711
        input = "\x99\xb6"
        output = CompactEncoder::getI16!(input)
        assert_equal(-4711, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI32_minus2147483648
        input = "\xc4\x00\x00\x00\x80"
        output = CompactEncoder::getI32!(input)
        assert_equal(-2147483648, output)
        assert_equal(0, input.size)
    end

    def test_getBool_true
        input = "\x01"
        output = CompactEncoder::getBool!(input)
        assert_equal(true, output)
        assert_equal(0, input.size)
    end

    def test_getBool_false
        input = "\x00"
        output = CompactEncoder::getBool!(input)
        assert_equal(false, output)
        assert_equal(0, input.size)
    end

    def test_getBool_other
        input = "\x02"
        assert_raise do
            CompactEncoder::getBool!(input)
        end
        assert_equal(0, input.size)
    end

    def test_getString
        input = "\x0bhello world"
        output = CompactEncoder::getString!(input)
        assert_equal("hello world", output)
        assert_equal(0, input.size)
    end

    def test_getBinary
        input = "\x0bhello world"
        output = CompactEncoder::getBinary!(input)
        assert_equal("hello world", output)
        assert_equal(0, input.size)
    end
    
end
