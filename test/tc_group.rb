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

class TestGroup < Test::Unit::TestCase

    include SlowBlink

    def test_empty_group_without_id
        input = "Test"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal("Test", schema.ns[nil].group("Test").nameWithID.name)
        assert_equal(nil, schema.ns[nil].group("Test").nameWithID.id)
        assert_equal([], schema.ns[nil].group("Test").fields)
        assert_equal({}, schema.tagged)        
    end

    def test_empty_group_with_id
        input = "Test/0"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal("Test", schema.ns[nil].group("Test").nameWithID.name)
        assert_equal(0, schema.ns[nil].group("Test").nameWithID.id)
        assert_equal([], schema.ns[nil].group("Test").fields)
        assert_equal({0 => schema.ns[nil].group("Test")}, schema.tagged)
    end

    def test_empty_group_with_hexid
        input = "Test/0x2a"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal("Test", schema.ns[nil].group("Test").nameWithID.name)
        assert_equal(42, schema.ns[nil].group("Test").nameWithID.id)
        assert_equal([], schema.ns[nil].group("Test").fields)
        assert_equal({42 => schema.ns[nil].group("Test")}, schema.tagged)
    end

    def test_group_of_one_field
        input = "Test -> u8 one"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(1, schema.ns[nil].group("Test").fields.size)
    end

    def test_group_of_many_field
        input = "Test -> u8 one, u8 two, u8 three"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(3, schema.ns[nil].group("Test").fields.size)        
    end

    def test_with_supergroup
        input = "Test : Super Super -> u8 one, u16 two, u32 three"        
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(3, schema.ns[nil].group("Test").fields.size)
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("Super"))
    end

    def test_without_supergroup
        input = "Test Super -> u8 one, u16 two, u32 three"        
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(0, schema.ns[nil].group("Test").fields.size)
        assert_true(!schema.ns[nil].group("Test").group_kind_of?(schema.ns[nil].group("Super")))
    end

    def test_with_multiple_supergroup

        input = "Test : Super Super : SuperSuper SuperSuper -> u8 one, u16 two, u32 three"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(3, schema.ns[nil].group("Test").fields.size)
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("Super"))
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("SuperSuper"))        
    end

    def test_with_mixed_supergroup
        input = "Test : Super -> u32 three Super -> u8 one, u16 two"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(3, schema.ns[nil].group("Test").fields.size)
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("Super"))
    end

end
