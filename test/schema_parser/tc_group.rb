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

    def test_empty_group
        input = "Test"
        schema = Schema.parse(input)

        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(nil, schema.group("Test").nameWithID.id)
        assert_equal({}, schema.group("Test").fields)
        
    end

    def test_empty_group_with_id
        input = "Test/0"
        schema = Schema.parse(input)

        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(0, schema.group("Test").nameWithID.id)
        assert_equal({}, schema.group("Test").fields)        
    end

    def test_group_of_one_field
        input = "Test -> u8 one"
        schema = Schema.parse(input)
        
        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(nil, schema.group("Test").nameWithID.id)
        assert_equal("one", schema.group("Test").field("one").nameWithID.name)
        assert_equal(nil, schema.group("Test").field("one").nameWithID.id)
        assert_equal(false, schema.group("Test").field("one").opt?)        
    end

    def test_group_of_one_field_optional
        input = "Test -> u8 one?"
        schema = Schema.parse(input)
        assert_equal(true, schema.group("Test").field("one").opt?)        
    end

    def test_group_of_one_field_with_id
        input = "Test -> u8 one/42"
        schema = Schema.parse(input)
        assert_equal(42, schema.group("Test").field("one").nameWithID.id)        
    end

    def test_group_of_one_field_optional_with_id
        input = "Test -> u8 one/42?"
        schema = Schema.parse(input)
        assert_equal(true, schema.group("Test").field("one").opt?)        
        assert_equal(42, schema.group("Test").field("one").nameWithID.id)        
    end

    def test_group_of_many_field
        input = "Test -> u8 one, u16 two?, u32 three"
        schema = Schema.parse(input)
        
        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(nil, schema.group("Test").nameWithID.id)
        assert_equal(3, schema.group("Test").fields.size)
        assert_equal("one", schema.group("Test").field("one").nameWithID.name)
        assert_equal("two", schema.group("Test").field("two").nameWithID.name)
        assert_equal("three", schema.group("Test").field("three").nameWithID.name)
        assert_equal(nil, schema.group("Test").field("one").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("two").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("three").nameWithID.id)
        assert_equal(false, schema.group("Test").field("one").opt?)        
        assert_equal(true, schema.group("Test").field("two").opt?)        
        assert_equal(false, schema.group("Test").field("three").opt?)        
    end

    def test_group_supergroup

        input = "Test : Super Super -> u8 one, u16 two?, u32 three"        
        schema = Schema.parse(input)
        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(nil, schema.group("Test").nameWithID.id)

        assert_equal("one", schema.group("Test").field("one").nameWithID.name)
        assert_equal("two", schema.group("Test").field("two").nameWithID.name)
        assert_equal("three", schema.group("Test").field("three").nameWithID.name)
        assert_equal(nil, schema.group("Test").field("one").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("two").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("three").nameWithID.id)
        assert_equal(false, schema.group("Test").field("one").opt?)        
        assert_equal(true, schema.group("Test").field("two").opt?)        
        assert_equal(false, schema.group("Test").field("three").opt?)        
    end

    def test_group_supergroup_supergroup

        input = "Test : Super Super : SuperSuper SuperSuper -> u8 one, u16 two?, u32 three"        
        schema = Schema.parse(input)
        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(nil, schema.group("Test").nameWithID.id)

        assert_equal("one", schema.group("Test").field("one").nameWithID.name)
        assert_equal("two", schema.group("Test").field("two").nameWithID.name)
        assert_equal("three", schema.group("Test").field("three").nameWithID.name)
        assert_equal(nil, schema.group("Test").field("one").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("two").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("three").nameWithID.id)
        assert_equal(false, schema.group("Test").field("one").opt?)        
        assert_equal(true, schema.group("Test").field("two").opt?)        
        assert_equal(false, schema.group("Test").field("three").opt?)        
    end

    def test_group_super_mix

        input = "Test : Super -> u32 three Super -> u8 one, u16 two?"        
        schema = Schema.parse(input)
        assert_not_equal(nil, schema.group("Test"))

        assert_equal("Test", schema.group("Test").nameWithID.name)
        assert_equal(nil, schema.group("Test").nameWithID.id)

        assert_equal("one", schema.group("Test").field("one").nameWithID.name)
        assert_equal("two", schema.group("Test").field("two").nameWithID.name)
        assert_equal("three", schema.group("Test").field("three").nameWithID.name)
        assert_equal(nil, schema.group("Test").field("one").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("two").nameWithID.id)
        assert_equal(nil, schema.group("Test").field("three").nameWithID.id)
        assert_equal(false, schema.group("Test").field("one").opt?)        
        assert_equal(true, schema.group("Test").field("two").opt?)        
        assert_equal(false, schema.group("Test").field("three").opt?)        
    
    end

end
