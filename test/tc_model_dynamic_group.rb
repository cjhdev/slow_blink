require "test/unit"
require 'slow_blink'

class TestModelDynamicGroup < Test::Unit::TestCase

    include SlowBlink

    def setup

        rawSchema = <<-eos
        DynamicGroup/0x01 ->
            string one,
            u8 two,
            u8 three
            
        Test/0x00 ->
            string one,
            u8 two,
            u8 three,
            DynamicGroup * four            
        eos

        schema = Schema.new(SchemaBuffer.new(rawSchema))
        @model = Message::Model.new(schema)
        
    end 

    def test_init

        message = @model.group("Test").new(
            "one" => "hello",
            "two" => 42,
            "three" => 42,
            "four" => @model.group("DynamicGroup").new( 
                "one" => "world",
                "two" => 42,
                "three" => 42
            )
        )

        assert_equal("hello", message["one"])
        assert_equal(42, message["two"])
        assert_equal(42, message["three"])
        assert_equal("world", message["four"]["one"])
        assert_equal(42, message["four"]["two"])        
        assert_equal(42, message["four"]["three"])        

    end

    def test_encode_compact

        message = @model.group("Test").new(
            "one" => "hello",
            "two" => 42,
            "three" => 42,
            "four" => @model.group("DynamicGroup").new( 
                "one" => "world",
                "two" => 42,
                "three" => 42
            )
        )

        output = message.encode_compact
        
        expected = "\x13\x00\x05hello\x2a\x2a\x09\x01\x05world\x2a\x2a"

        assert_equal(expected, output)
    
    end

    def test_decode_compact

        input = "\x13\x00\x05hello\x2a\x2a\x09\x01\x05world\x2a\x2a"

        message = @model.decode_compact(input)

        assert_equal("hello", message["one"])
        assert_equal(42, message["two"])
        assert_equal(42, message["three"])
        assert_equal("world", message["four"]["one"])
        assert_equal(42, message["four"]["two"])        
        assert_equal(42, message["four"]["three"])  
    
    end
    
end
