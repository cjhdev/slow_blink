require "test/unit"
require 'slow_blink'

class TestModelSequenceOfString < Test::Unit::TestCase

    include SlowBlink

    def setup
        schema = Schema.new(SchemaBuffer.new("Test/0 -> string [] Field"))
        @model = Message::Model.new(schema)        
    end

    def test_init
        assert_equal(["hello", "world"], @model.group("Test").new("Field" => ["hello", "world"])["Field"])            
    end

    def test_encode_compact
        output = @model.group("Test").new("Field" => ["hello", "world"]).encode_compact.force_encoding("ASCII-8BIT")
        expected = "\x0e\x00\x02\x05hello\x05world".force_encoding("ASCII-8BIT")
        assert_equal(expected, output)
    end

    def test_decode_compact
        input = "\x0e\x00\x02\x05hello\x05world".force_encoding("ASCII-8BIT")
        expected = ["hello", "world"]
        assert_equal(expected, @model.decode_compact(input)["Field"])    
    end
    
end
