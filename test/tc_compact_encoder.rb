require "test/unit"
require 'slow_blink'

class TestCompactEncoder < Test::Unit::TestCase

    include SlowBlink

    def test_putU8
        input = 0x7f
        output = String.new.putU8(input)
        assert_equal("\x7f".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU8_big
        input = 0x80
        output = String.new.putU8(input)
        assert_equal("\x80\x02".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU8_tooBig
        input = 0x100
        assert_raise RangeError do
            String.new.putU8(input)
        end
    end

    def test_putU8_null
        input = nil
        output = String.new.putU8(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU16_small
        input = 0xff
        output = String.new.putU16(input)
        assert_equal("\xbf\x03".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU16
        input = 0xffff
        output = String.new.putU16(input)
        assert_equal("\xC2\xff\xff".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putU8_64unsigned
        input = 64
        output = String.new.putU8(input)
        assert_equal("\x40".force_encoding("ASCII-8BIT"), output)
    end

    def test_putU16_16383
        input = 16383
        output = String.new.putU16(input)
        assert_equal("\xBf\xff".force_encoding("ASCII-8BIT"), output)
    end

    def test_putI16_16383
        input = 16383
        output = String.new.putI16(input)
        assert_equal("\xC2\xff\x3f".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI8_64signed
        input = 64
        output = String.new.putI8(input)
        assert_equal("\x80\x01".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putU16_4711unsigned
        input = 4711
        output = String.new.putU16(input)
        assert_equal("\xa7\x49".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putU32_4294967295unsigned
        input = 4294967295
        output = String.new.putU32(input)
        assert_equal("\xc4\xff\xff\xff\xff".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI8_minus64
        input = -64
        output = String.new.putI8(input)
        assert_equal("\x40".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI16_minus4711
        input = -4711
        output = String.new.putI16(input)
        assert_equal("\x99\xb6".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_putI32_minus2147483648
        input = -2147483648
        output = String.new.putI32(input)
        assert_equal("\xc4\x00\x00\x00\x80".force_encoding("ASCII-8BIT"), output)
    end

    def test_putFixed
        input = "hello world"
        output = String.new.putFixed(input)
        assert_equal("hello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putFixedOptional
        input = "hello world"
        output = String.new.putFixedOptional(input)
        assert_equal("\x01hello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putFixedOptional_null
        input = nil
        output = String.new.putFixedOptional(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putString
        input = "hello world"
        output = String.new.putString(input)
        assert_equal("\x0bhello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putString_null
        input = nil
        output = String.new.putString(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBinary
        input = "hello world"
        output = String.new.putBinary(input)
        assert_equal("\x0bhello world".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBinary_null
        input = nil
        output = String.new.putBinary(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBool_true
        input = true
        output = String.new.putBool(input)
        assert_equal("\x01".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBool_false
        input = false
        output = String.new.putBool(input)
        assert_equal("\x00".force_encoding("ASCII-8BIT"), output)
    end

    def test_putBool_null
        input = nil
        output = String.new.putBool(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    def test_putF64
        input = nil
        output = String.new.putF64(input)
        assert_equal("\xc0".force_encoding("ASCII-8BIT"), output)
    end

    # Blink Specification 3.1
    def test_getU8_64unsigned
        input = StringIO.new("\x40")
        output = input.getU8
        assert_equal(64, output)
        
    end

    # Blink Specification 3.1
    def test_getI8_64signed
        input = StringIO.new("\x80\x01")
        output = input.getI8
        assert_equal(64, output)
        
    end

    # Blink Specification 3.1
    def test_getU16_4711unsigned
        input = StringIO.new("\xa7\x49")
        output = input.getU16
        assert_equal(4711, output)
        
    end

    # Blink Specification 3.1
    def test_getU32_4294967295unsigned
        input = StringIO.new("\xc4\xff\xff\xff\xff")
        output = input.getU32
        assert_equal(4294967295, output)
        
    end

    # Blink Specification 3.1
    def test_getI8_minus64
        input = StringIO.new("\x40")
        output = input.getI8
        assert_equal(-64, output)
        
    end

    # Blink Specification 3.1
    def test_getI16_minus4711
        input = StringIO.new("\x99\xb6")
        output = input.getI16
        assert_equal(-4711, output)
        
    end

    # Blink Specification 3.1
    def test_getI32_minus2147483648
        input = StringIO.new("\xc4\x00\x00\x00\x80")
        output = input.getI32
        assert_equal(-2147483648, output)
        
    end

    def test_getBool_true
        input = StringIO.new("\x01")
        output = input.getBool
        assert_equal(true, output)
        
    end

    def test_getBool_false
        input = StringIO.new("\x00")
        output = input.getBool
        assert_equal(false, output)
        
    end

    def test_getBool_other
        input = StringIO.new("\x02")
        assert_raise Message::WeakError11 do
            input.getBool
        end
        
    end

    def test_getString
        input = StringIO.new("\x0bhello world")
        output = input.getString
        assert_equal("hello world", output)
        
    end
    
    def test_getString_null
        input = StringIO.new("\xc0")
        output = input.getString
        assert_equal(nil, output)
        
    end

    def test_getString_eof
        input = StringIO.new("\x01")
        assert_raise Message::StrongError1 do
            input.getString
        end
    end

    def test_getBinary
        input = StringIO.new("\x0bhello world")
        output = input.getBinary
        assert_equal("hello world", output)
        
    end

    def test_getBinary_null
        input = StringIO.new("\xc0")
        output = input.getBinary
        assert_equal(nil, output)
        
    end

    def test_getBinary_eof
        input = StringIO.new("\x01")
        assert_raise Message::StrongError1 do
            input.getBinary
        end
    end
    
    def test_getFixed
        input = StringIO.new("hello world")
        output = input.getFixed("hello world".size)
        assert_equal("hello world", output)
        
    end

    def test_getFixed_eof
        input = StringIO.new
        assert_raise Message::StrongError1 do
            input.getFixed(1)
        end
    end

    def test_getFixedOptional
        input = StringIO.new("\x01hello world")
        output = input.getFixedOptional("hello world".size)
        assert_equal("hello world", output)
        
    end

    def test_getFixedOptional_null
        input = StringIO.new("\xc0")
        output = input.getFixedOptional("hello world".size)
        assert_equal(nil, output)
        
    end

    def test_getFixedOptional_eof
        input = StringIO.new("\x01")
        assert_raise Message::StrongError1 do
            input.getFixedOptional(1)
        end
    end

    def test_getI64_max
        input = StringIO.new("\xC8\xff\xff\xff\xff\xff\xff\xff\x7f")
        expected = 9223372036854775807
        assert_equal(expected, input.getI64)
    end

    def test_putI64_max
        expected = "\xC8\xff\xff\xff\xff\xff\xff\xff\x7f".force_encoding("ASCII-8BIT")
        input = 9223372036854775807
        assert_equal(expected, String.new.putI64(input))
    end

    def test_getI64_min
        input = StringIO.new("\xC8\x00\x00\x00\x00\x00\x00\x00\x80")
        expected = -9223372036854775808
        assert_equal(expected, input.getI64)
    end

    def test_putI64_min
        expected = "\xC8\x00\x00\x00\x00\x00\x00\x00\x80".force_encoding("ASCII-8BIT")
        input = -9223372036854775808
        assert_equal(expected, String.new.putI64(input))
    end

    def test_getI32_max
        input = StringIO.new("\xC4\xff\xff\xff\x7f")
        expected = 2147483647
        assert_equal(expected, input.getI32)
    end

    def test_getI32_min
        input = StringIO.new("\xC4\x00\x00\x00\x80")
        expected = -2147483648
        assert_equal(expected, input.getI32)
    end

    def test_getI16_max
        input = StringIO.new("\xC2\xff\x7f")
        expected = 32767
        assert_equal(expected, input.getI32)
    end

    def test_getI16_min
        input = StringIO.new("\xC2\x00\x80")
        expected = -32768
        assert_equal(expected, input.getI32)
    end
    
end
