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
        assert_true(schema.ns[nil].group("Test").field("one") != nil)
        assert_true(schema.ns[nil].group("Test").field("two") != nil)
        assert_true(schema.ns[nil].group("Test").field("three") != nil)
    end

    def test_without_supergroup
        input = "Test Super -> u8 one, u16 two, u32 three"        
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(0, schema.ns[nil].group("Test").fields.size)
        assert_true(!schema.ns[nil].group("Test").group_kind_of?(schema.ns[nil].group("Super")))
        assert_true(schema.ns[nil].group("Test").field("one") == nil)
        assert_true(schema.ns[nil].group("Test").field("two") == nil)
        assert_true(schema.ns[nil].group("Test").field("three") == nil)
    end

    def test_with_multiple_supergroup

        input = "Test : Super Super : SuperSuper SuperSuper -> u8 one, u16 two, u32 three"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(3, schema.ns[nil].group("Test").fields.size)
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("Super"))
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("SuperSuper"))
        assert_true(schema.ns[nil].group("Test").field("one") != nil)
        assert_true(schema.ns[nil].group("Test").field("two") != nil)
        assert_true(schema.ns[nil].group("Test").field("three") != nil)
    end

    def test_with_mixed_supergroup
        input = "Test : Super -> u32 three Super -> u8 one, u16 two"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(3, schema.ns[nil].group("Test").fields.size)
        assert_true(schema.ns[nil].group("Test").group_kind_of? schema.ns[nil].group("Super"))
        assert_true(schema.ns[nil].group("Test").field("one") != nil)
        assert_true(schema.ns[nil].group("Test").field("two") != nil)
        assert_true(schema.ns[nil].group("Test").field("three") != nil)
    end

    def test_supergroup_not_group
        input = "Test : Thing Thing = u8"
        assert_raise do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_supergroup_unresolved
        input = "Test : Thing"
        assert_raise do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_supergroup_dynamic_reference
        input =  <<-eos
            Super
            Intermediate = Super *
            Test : Intermediate
        eos
        assert_raise do
            Schema.new(SchemaBuffer.new(input))
        end        
    end

end
