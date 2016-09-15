require "test/unit"
require 'slow_blink'

class TestCompactEncoder < Test::Unit::TestCase

    include SlowBlink

    def test_putU8
        input = 0x7f
        output = "".putU8(input)
        assert_equal("\x7f", output)
    end

    def test_putU8_big
        input = 0x80
        output = "".putU8(input)
        assert_equal("\x80\x02", output)
    end

    def test_putU8_tooBig
        input = 0x100
        assert_raise do
            "".putU8(input)
        end
    end

    def test_putU8_null
        input = nil
        output = "".putU8(input)
        assert_equal("\xc0", output)
    end

    def test_putU16_small
        input = 0xff
        output = "".putU16(input)
        assert_equal("\xbf\x03", output)
    end

    def test_putU16
        input = 0xffff
        output = "".putU16(input)
        assert_equal("\xC2\xff\xff", output)
    end

    # Blink Specification 3.1
    def test_putU8_64unsigned
        input = 64
        output = "".putU8(input)
        assert_equal("\x40", output)
    end

    # Blink Specification 3.1
    def test_putI8_64signed
        input = 64
        output = "".putI8(input)
        assert_equal("\x80\x01", output)
    end

    # Blink Specification 3.1
    def test_putU16_4711unsigned
        input = 4711
        output = "".putU16(input)
        assert_equal("\xa7\x49", output)
    end

    # Blink Specification 3.1
    def test_putU32_4294967295unsigned
        input = 4294967295
        output = "".putU32(input)
        assert_equal("\xc4\xff\xff\xff\xff", output)
    end

    # Blink Specification 3.1
    def test_putI8_minus64
        input = -64
        output = "".putI8(input)
        assert_equal("\x40", output)
    end

    # Blink Specification 3.1
    def test_putI16_minus4711
        input = -4711
        output = "".putI16(input)
        assert_equal("\x99\xb6", output)
    end

    # Blink Specification 3.1
    def test_putI32_minus2147483648
        input = -2147483648
        output = "".putI32(input)
        assert_equal("\xc4\x00\x00\x00\x80", output)
    end

    def test_putFixed
        input = "hello world"
        output = "".putFixed(input)
        assert_equal("hello world", output)
    end

    def test_putFixedOptional
        input = "hello world"
        output = "".putFixedOptional(input)
        assert_equal("\x01hello world", output)
    end

    def test_putFixedOptional_null
        input = nil
        output = "".putFixedOptional(input)
        assert_equal("\xc0", output)
    end

    def test_putString
        input = "hello world"
        output = "".putString(input)
        assert_equal("\x0bhello world", output)
    end

    def test_putString_null
        input = nil
        output = "".putString(input)
        assert_equal("\xc0", output)
    end

    def test_putBinary
        input = "hello world"
        output = "".putBinary(input)
        assert_equal("\x0bhello world", output)
    end

    def test_putBinary_null
        input = nil
        output = "".putBinary(input)
        assert_equal("\xc0", output)
    end

    def test_putBool_true
        input = true
        output = "".putBool(input)
        assert_equal("\x01", output)
    end

    def test_putBool_false
        input = false
        output = "".putBool(input)
        assert_equal("\x00", output)
    end

    def test_putBool_null
        input = nil
        output = "".putBool(input)
        assert_equal("\xc0", output)
    end

    def test_putF64
        input = nil
        output = "".putF64(input)
        assert_equal("\xc0", output)
    end

    # Blink Specification 3.1
    def test_getU8_64unsigned
        input = "\x40"
        output = input.getU8!
        assert_equal(64, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI8_64signed
        input = "\x80\x01"
        output = input.getI8!
        assert_equal(64, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getU16_4711unsigned
        input = "\xa7\x49"
        output = input.getU16!
        assert_equal(4711, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getU32_4294967295unsigned
        input = "\xc4\xff\xff\xff\xff"
        output = input.getU32!
        assert_equal(4294967295, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI8_minus64
        input = "\x40"
        output = input.getI8!
        assert_equal(-64, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI16_minus4711
        input = "\x99\xb6"
        output = input.getI16!
        assert_equal(-4711, output)
        assert_equal(0, input.size)
    end

    # Blink Specification 3.1
    def test_getI32_minus2147483648
        input = "\xc4\x00\x00\x00\x80"
        output = input.getI32!
        assert_equal(-2147483648, output)
        assert_equal(0, input.size)
    end

    def test_getBool_true
        input = "\x01"
        output = input.getBool!
        assert_equal(true, output)
        assert_equal(0, input.size)
    end

    def test_getBool_false
        input = "\x00"
        output = input.getBool!
        assert_equal(false, output)
        assert_equal(0, input.size)
    end

    def test_getBool_other
        input = "\x02"
        assert_raise do
            input.getBool!
        end
        assert_equal(0, input.size)
    end

    def test_getString
        input = "\x0bhello world"
        output = input.getString!
        assert_equal("hello world", output)
        assert_equal(0, input.size)
    end
    
    def test_getString_null
        input = "\xc0"
        output = input.getString!
        assert_equal(nil, output)
        assert_equal(0, input.size)
    end

    def test_getString_eof
        input = "\x01"
        assert_raise do
            input.getString!
        end
    end

    def test_getBinary
        input = "\x0bhello world"
        output = input.getBinary!
        assert_equal("hello world", output)
        assert_equal(0, input.size)
    end

    def test_getBinary_null
        input = "\xc0"
        output = input.getBinary!
        assert_equal(nil, output)
        assert_equal(0, input.size)
    end

    def test_getBinary_eof
        input = "\x01"
        assert_raise do
            input.getBinary!
        end
    end
    
    def test_getFixed
        input = "hello world"
        output = input.getFixed!("hello world".size)
        assert_equal("hello world", output)
        assert_equal(0, input.size)
    end

    def test_getFixed_eof
        input = ""
        assert_raise do
            input.getFixed!(1)
        end
    end

    def test_getFixedOptional
        input = "\x01hello world"
        output = input.getFixedOptional!("hello world".size)
        assert_equal("hello world", output)
        assert_equal(0, input.size)
    end

    def test_getFixedOptional_null
        input = "\xc0"
        output = input.getFixedOptional!("hello world".size)
        assert_equal(nil, output)
        assert_equal(0, input.size)
    end

    def test_getFixedOptional_eof
        input = "\x01"
        assert_raise do
            input.getFixedOptional!(1)
        end
    end

    def test_getU32_13548
        input = "\x01"
        assert_raise do
            input.getFixedOptional!(1)
        end
    end
    
end
