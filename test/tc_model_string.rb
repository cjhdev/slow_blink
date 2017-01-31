require "test/unit"
require 'slow_blink'

class TestModelString < Test::Unit::TestCase

    include SlowBlink

    def setup
        schema = Schema.new(SchemaBuffer.new("Test/0 -> string Field"))
        @model = Message::Model.new(schema)        
    end

    def test_init
        assert_equal("hello", @model.group("Test").new("Field" => "hello")["Field"])            
    end

    def test_encode_compact
        output = @model.group("Test").new("Field" => "hello").encode_compact.force_encoding("ASCII-8BIT")
        expected = "\x07\x00\x05hello".force_encoding("ASCII-8BIT")
        assert_equal(expected, output)
    end

    def test_decode_compact
        input = "\x07\x00\x05hello".force_encoding("ASCII-8BIT")
        expected = "hello"
        assert_equal(expected, @model.decode_compact(input)["Field"])    
    end
    
end
