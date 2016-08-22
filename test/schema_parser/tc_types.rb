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

class TestTypes < Test::Unit::TestCase

    include SlowBlink

    def test_bool
        input = "test -> bool test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(BOOLEAN, schema.group("test").field("test").type.class)
    end

    def test_u8
        input = "test -> u8 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(U8, schema.group("test").field("test").type.class)
    end

    def test_u16
        input = "test -> u16 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(U16, schema.group("test").field("test").type.class)
    end

    def test_u32
        input = "test -> u32 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(U32, schema.group("test").field("test").type.class)
    end

    def test_u64
        input = "test -> u64 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(U64, schema.group("test").field("test").type.class)
    end

    def test_i8
        input = "test -> i8 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(I8, schema.group("test").field("test").type.class)
    end

    def test_i16
        input = "test -> i16 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(I16, schema.group("test").field("test").type.class)
    end

    def test_i32
        input = "test -> i32 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(I32, schema.group("test").field("test").type.class)
    end

    def test_i64
        input = "test -> i64 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(I64, schema.group("test").field("test").type.class)
    end

    def test_f64
        input = "test -> f64 test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(F64, schema.group("test").field("test").type.class)
    end

    def test_string
        input = "test -> string test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(nil, schema.group("test").field("test").type.size)
        assert_equal(STRING, schema.group("test").field("test").type.class)
    end

    def test_string_size
        input = "test -> string (42) test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(STRING, schema.group("test").field("test").type.class)
        assert_equal(42, schema.group("test").field("test").type.size)        
    end
    
    def test_binary
        input = "test -> binary test"
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(BINARY, schema.group("test").field("test").type.class)
        assert_equal(nil, schema.group("test").field("test").type.size)
        
    end

    def test_binary_size
        input = "test -> binary (42) test "
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(BINARY, schema.group("test").field("test").type.class)        
        assert_equal(42, schema.group("test").field("test").type.size)
    end

    def test_ref_string_size
        input = "ref = string (1) test -> ref test "
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(REF, schema.group("test").field("test").type.class)
        assert_equal(STRING, schema.group("test").field("test").type.object.class)
        assert_equal(1, schema.group("test").field("test").type.object.size)        
    end

    def test_refref_string_size
        input = "refref = string (1) ref = refref  test -> refref test "
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(REF, schema.group("test").field("test").type.class)
        assert_equal(STRING, schema.group("test").field("test").type.object.class)
        assert_equal(1, schema.group("test").field("test").type.object.size)        
    end

    def test_enum
        input = "colour = | blue test -> colour test "
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(REF, schema.group("test").field("test").type.class)
        assert_equal(Enumeration, schema.group("test").field("test").type.object.class)
        assert_equal("blue", schema.group("test").field("test").type.object.symbol("blue").name)
        assert_equal(0, schema.group("test").field("test").type.object.symbol("blue").val)
        
    end

    def test_enum_many
        input = "colour = blue | white | red/5 test -> colour test "
        schema = Schema.parse(input)

        assert_equal("test", schema.group("test").field("test").nameWithID.name)
        assert_equal(nil, schema.group("test").field("test").nameWithID.id)
        assert_equal(REF, schema.group("test").field("test").type.class)
        assert_equal(Enumeration, schema.group("test").field("test").type.object.class)
        assert_equal("blue", schema.group("test").field("test").type.object.symbol("blue").name)
        assert_equal(0, schema.group("test").field("test").type.object.symbol("blue").val)
        assert_equal("white", schema.group("test").field("test").type.object.symbol("white").name)
        assert_equal(1, schema.group("test").field("test").type.object.symbol("white").val)
        assert_equal("red", schema.group("test").field("test").type.object.symbol("red").name)
        assert_equal(5, schema.group("test").field("test").type.object.symbol("red").val)
    end


end
