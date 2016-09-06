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
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(BOOLEAN, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_u8
        input = "test -> u8 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(U8, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_u16
        input = "test -> u16 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(U16, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_u32
        input = "test -> u32 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(U32, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_u64
        input = "test -> u64 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(U64, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_i8
        input = "test -> i8 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(I8, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_i16
        input = "test -> i16 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(I16, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_i32
        input = "test -> i32 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(I32, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_i64
        input = "test -> i64 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(I64, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_f64
        input = "test -> f64 test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(FLOATING_POINT, schema.ns[nil].group("test").field("test").type.class)
    end

    def test_string_without_size
        input = "test -> string test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(STRING, schema.ns[nil].group("test").field("test").type.class)
        assert_equal(nil, schema.ns[nil].group("test").field("test").type.size)        
    end

    def test_string_with_size
        input = "test -> string (42) test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(STRING, schema.ns[nil].group("test").field("test").type.class)
        assert_equal(42, schema.ns[nil].group("test").field("test").type.size)       
    end
    
    def test_binary_without_size
        input = "test -> binary test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(BINARY, schema.ns[nil].group("test").field("test").type.class)
        assert_equal(nil, schema.ns[nil].group("test").field("test").type.size)        
    end

    def test_binary_with_size
        input = "test -> binary (42) test "
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(BINARY, schema.ns[nil].group("test").field("test").type.class)        
        assert_equal(42, schema.ns[nil].group("test").field("test").type.size)
    end

    def test_fixed
        input = "test -> fixed (42) test "
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(FIXED, schema.ns[nil].group("test").field("test").type.class)        
        assert_equal(42, schema.ns[nil].group("test").field("test").type.size)
    end

    def test_enum
        input = "colour = | blue"
        schema = Schema.new(SchemaBuffer.new(input))
    end

    def test_enum_many
        input = "colour = blue | white | red/5"
        schema = Schema.new(SchemaBuffer.new(input))
    end

    def test_ref_enum
        input = "colour = | blue test -> colour test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(REF, schema.ns[nil].group("test").field("test").type.class)
        assert_equal(ENUMERATION, schema.ns[nil].group("test").field("test").type.ref.class)
        assert_equal("blue", schema.ns[nil].group("test").field("test").type.ref.symbol("blue").name)
        assert_equal(0, schema.ns[nil].group("test").field("test").type.ref.symbol("blue").val)        
    end

    def test_ref_enum_many
        input = "colour = blue | white | red/5 | orange test -> colour test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(REF, schema.ns[nil].group("test").field("test").type.class)
        assert_equal(ENUMERATION, schema.ns[nil].group("test").field("test").type.ref.class)
        assert_equal("blue", schema.ns[nil].group("test").field("test").type.ref.symbol("blue").name)
        assert_equal(0, schema.ns[nil].group("test").field("test").type.ref.symbol("blue").val)        
        assert_equal("white", schema.ns[nil].group("test").field("test").type.ref.symbol("white").name)
        assert_equal(1, schema.ns[nil].group("test").field("test").type.ref.symbol("white").val)        
        assert_equal("red", schema.ns[nil].group("test").field("test").type.ref.symbol("red").name)
        assert_equal(5, schema.ns[nil].group("test").field("test").type.ref.symbol("red").val)        
        assert_equal("orange", schema.ns[nil].group("test").field("test").type.ref.symbol("orange").name)
        assert_equal(6, schema.ns[nil].group("test").field("test").type.ref.symbol("orange").val)        
    end

    def test_static_group
        input = "static -> u8 one, u16 two test -> static one, string two"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal("one", schema.ns[nil].group("test").field("one").nameWithID.name)
        assert_equal(REF, schema.ns[nil].group("test").field("one").type.class)
        assert_equal(false, schema.ns[nil].group("test").field("one").type.dynamic?)
        assert_equal("two", schema.ns[nil].group("test").field("two").nameWithID.name)
        assert_equal(STRING, schema.ns[nil].group("test").field("two").type.class)
        assert_equal("one", schema.ns[nil].group("test").field("one").type.ref.field("one").nameWithID.name)
        assert_equal(U8, schema.ns[nil].group("test").field("one").type.ref.field("one").type.class)
        assert_equal("two", schema.ns[nil].group("test").field("one").type.ref.field("two").nameWithID.name)
        assert_equal(U16, schema.ns[nil].group("test").field("one").type.ref.field("two").type.class)        
    end

    def test_dynamic_group
        input = "dynamic -> u8 one, u16 two test -> dynamic * one, string two"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal("one", schema.ns[nil].group("test").field("one").nameWithID.name)
        assert_equal(REF, schema.ns[nil].group("test").field("one").type.class)
        assert_equal(true, schema.ns[nil].group("test").field("one").type.dynamic?)
        assert_equal("two", schema.ns[nil].group("test").field("two").nameWithID.name)
        assert_equal(STRING, schema.ns[nil].group("test").field("two").type.class)
        assert_equal("one", schema.ns[nil].group("test").field("one").type.ref.field("one").nameWithID.name)
        assert_equal(U8, schema.ns[nil].group("test").field("one").type.ref.field("one").type.class)
        assert_equal("two", schema.ns[nil].group("test").field("one").type.ref.field("two").nameWithID.name)
        assert_equal(U16, schema.ns[nil].group("test").field("one").type.ref.field("two").type.class)        
    end

    def test_dynamic_not_group
        input = "thing = u8 one test -> thing * one, string two"
        assert_raise do
           Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_any_group
        input = "dynamic -> u8 one, u16 two test -> object one, string two"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal("one", schema.ns[nil].group("test").field("one").nameWithID.name)
        assert_equal(OBJECT, schema.ns[nil].group("test").field("one").type.class)        
    end

    def test_type_direct_reference_cycle
        input =  <<-eos
            thing = thingref
            thingref = thing
        eos
        assert_raise do
           Schema.new(SchemaBuffer.new(input))
        end        
    end

    def test_type_inderect_reference_cycle
        input =  <<-eos
            thing = intermediate
            intermediate = thingref
            thingref = thing
        eos
        assert_raise do
           Schema.new(SchemaBuffer.new(input))
        end        
    end

end
