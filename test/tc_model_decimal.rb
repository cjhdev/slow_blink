require "test/unit"
require 'slow_blink'

class TestModelDecimal < Test::Unit::TestCase

    include SlowBlink

    def setup
        schema = Schema.new(SchemaBuffer.new("Test/0 -> decimal Field"))
        @model = Message::Model.new(schema)        
    end 

    def test_init_integer
        assert_equal(42, @model.group("Test").new("Field" => 42)["Field"])            
    end

    def test_init_float
        assert_equal(42.1, @model.group("Test").new("Field" => 42.1)["Field"])            
    end

    def test_init_scientific
        assert_equal(4210, @model.group("Test").new("Field" => "42.1E2")["Field"])            
    end

    def test_init_scientific_negative_exponent
        assert_equal(0.421, @model.group("Test").new("Field" => "42.1E-2")["Field"])            
    end

    def test_encode_compact_integer

        output = @model.group("Test").new("Field" => 42).encode_compact.force_encoding("ASCII-8BIT")
        expected = "\x03\x00\x00\x2a".force_encoding("ASCII-8BIT")
        assert_equal(expected, output)
    
    end
    
    def test_encode_compact_float

        output = @model.group("Test").new("Field" => 42.1).encode_compact.force_encoding("ASCII-8BIT")
        expected = "\x04\x00\x7f\xa5\x06".force_encoding("ASCII-8BIT")
        assert_equal(expected, output)
    
    end
    
    def test_encode_compact_scientific

        output = @model.group("Test").new("Field" => "42.1E2").encode_compact.force_encoding("ASCII-8BIT")
        expected = "\x04\x00\x01\xa5\x06".force_encoding("ASCII-8BIT")
        assert_equal(expected, output)
    
    end

    def test_encode_compact_scientific_negative_exponent

        output = @model.group("Test").new("Field" => "42.1E-2").encode_compact.force_encoding("ASCII-8BIT")
        expected = "\x04\x00\x7d\xa5\x06".force_encoding("ASCII-8BIT")
        assert_equal(expected, output)
    
    end

    def test_decode_compact_integer

        input = "\x03\x00\x00\x2a".force_encoding("ASCII-8BIT")
        expected = 42
        assert_equal(expected, @model.decode_compact(input)["Field"])
    
    end
    
    def test_decode_compact_float

        input = "\x04\x00\x7f\xa5\x06".force_encoding("ASCII-8BIT")
        expected = 42.1        
        assert_equal(expected, @model.decode_compact(input)["Field"])
    
    end
    
    def test_decode_compact_scientific

        input = "\x04\x00\x01\xa5\x06".force_encoding("ASCII-8BIT")
        expected = 4210        
        assert_equal(expected, @model.decode_compact(input)["Field"])
    
    end

    def test_decode_compact_scientific_negative_exponent

        input = "\x04\x00\x7d\xa5\x06".force_encoding("ASCII-8BIT")
        expected = 0.421        
        assert_equal(expected, @model.decode_compact(input)["Field"])
    
    end
    
    
end
