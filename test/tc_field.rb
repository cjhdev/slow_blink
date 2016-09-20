require "test/unit"
require 'slow_blink'

class TestField < Test::Unit::TestCase

    include SlowBlink

    def test_optional
        input = "Test -> u8 one?"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(true, schema.ns[nil].group("Test").field("one").opt?)        
    end

    def test_not_optional
        input = "Test -> u8 one"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(false, schema.ns[nil].group("Test").field("one").opt?)        
    end

    def test_with_id
        input = "Test -> u8 one/42"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(42, schema.ns[nil].group("Test").field("one").nameWithID.id)
    end

    def test_with_hexid
        input = "Test -> u8 one/0x2a"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(42, schema.ns[nil].group("Test").field("one").nameWithID.id)
    end

    def test_without_id
        input = "Test -> u8 one"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_equal(nil, schema.ns[nil].group("Test").field("one").nameWithID.id)
    end

    def test_reference
        input = "Ref = u8 Test -> Ref one"
        schema = Schema.new(SchemaBuffer.new(input))
        assert_true(schema.ns[nil].group("Test").field("one").type.is_a? REF)
        assert_true(schema.ns[nil].group("Test").field("one").type.ref.is_a? U8)
    end

    def test_duplicate_name
        input = "Ref = u8 Test -> Ref one, Ref one"
        
        assert_raise do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_field_direct_cycle
        input =  <<-eos
            test ->
                test field
        eos
        assert_raise do
            Schema.new(SchemaBuffer.new(input))
        end    
    end

    def test_field_direct_dynamic_cycle
        input =  <<-eos
            test ->
                test * field
        eos
        
        Schema.new(SchemaBuffer.new(input))
        
    end

    def test_field_indirect_cycle
        input =  <<-eos
            intermediate = test
            test ->
                intermediate field
        eos
        assert_raise do
            Schema.new(SchemaBuffer.new(input))
        end    
    end

    def test_field_indirect_dynamic_cycle
        input =  <<-eos
            intermediate = test *
            test ->
                intermediate field
        eos
        
        Schema.new(SchemaBuffer.new(input))
    end

    def test_field_escaped_name
        input =  "test -> u8 \\u8"
        
        schema = Schema.new(SchemaBuffer.new(input))

        assert_equal("u8", schema.groups["test"].field("u8").nameWithID.name)
    end

    def test_field_unescaped_keyword
        input =  "test -> u8 u8"

        assert_raise do
            schema = Schema.new(SchemaBuffer.new(input))
        end

    end

end
