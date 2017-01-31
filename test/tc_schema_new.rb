require "test/unit"
require 'slow_blink'

class TestTypes < Test::Unit::TestCase

    include SlowBlink

    def test_empty_group
        input = "test"
        Schema.new(SchemaBuffer.new(input))        
    end

    def test_empty_super_group
        input = <<-eos
            super
            empty : super
        eos
        Schema.new(SchemaBuffer.new(input))
    end

    def test_undefined_super_group
        input = "empty : super"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_group_is_super_group
        input = "empty : empty"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_group_is_super_group_by_intermediate
        input = <<-eos
            intermediate = empty
            empty : intermediate
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_super_group_is_dynamic
        input = <<-eos
            super
            intermediate = super*
            empty : intermediate
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_super_group_is_sequence
        input = <<-eos
            super
            intermediate = super []
            empty : intermediate
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_greeting
        input = "Message/0 -> string Greeting"
        Schema.new(SchemaBuffer.new(input))    
    end

    def test_namespace_empty_group
        input = "namespace test empty"
        Schema.new(SchemaBuffer.new(input))    
    end

    def test_enum_single
        input = "test = | lonely"
        Schema.new(SchemaBuffer.new(input))    
    end

    def test_circular_type_reference
        input = <<-eos
            test = testTwo
            testTwo = test
        eos
        
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_duplicate_type_reference
        input = <<-eos
            test = u8
            test = u16
        eos
                
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_duplicate_type_group_definition
        input = <<-eos
            test = u8
            test -> u16 field
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_duplicate_group_definition
        input = <<-eos
            test -> u8 field
            test -> u16 field
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_duplicate_enum_definition
        input = <<-eos
            test = | bla
            test = | bla
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_duplicate_enum_field
        input = "test = bla | bla"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_ambiguous_enum_value
        input = "Month = Jan/1 | Feb | Mar/2"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_enum_value_upper_limit
        input = "Month = | Jan/2147483648"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end        
    end

    def test_enum_value_lower_limit
        input = "Month = | Jan/-2147483649"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end        
    end

    def test_duplicate_group_field
        input = "test -> u8 bla, u8 bla"
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_super_group_shadow_field
        input = <<-eos
            super -> u8 field
            test : super -> u16 field
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end

    def test_super_super_group_shadow_field
        input = <<-eos
            superSuper -> u8 field
            super : superSuper -> u8 different
            test : super -> u16 field
        eos
        assert_raise ParseError do
            Schema.new(SchemaBuffer.new(input))
        end
    end
    
end
