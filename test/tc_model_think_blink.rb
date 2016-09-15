require "test/unit"
require 'slow_blink'

class TestModelThinkBlink < Test::Unit::TestCase

    include SlowBlink

    def setup
        rawSchema = <<-eos
        OrderExecuted/0x4c ->
            string Symbol,
            u64 OrderId,
            u32 Price,
            u32 Qty,
            u8 MatchId
        eos
        schema = Schema.new(SchemaBuffer.new(rawSchema))        
        @model = Message::Model.new(schema)
    end

    def test_set

        message = @model.group("OrderExecuted").new(        
            "Symbol" => "hey",
            "OrderId" => 42,
            "Price" => 42,
            "Qty" => 42,
            "MatchId" => 42
        )
        
        assert_equal("hey", message["Symbol"])
        assert_equal(42, message["OrderId"])
        assert_equal(42, message["Price"])
        assert_equal(42, message["Qty"])
        assert_equal(42, message["MatchId"])        
    
    end

    def test_encode_compact
        
        message = @model.group("OrderExecuted").new(        
            "Symbol" => "hey",
            "OrderId" => 42,
            "Price" => 42,
            "Qty" => 42,
            "MatchId" => 42
        )

        output = message.encode_compact
        
        expected = "\x09\x4c\x03hey\x2a\x2a\x2a\x2a"

        assert_equal(expected, output)

    end

    def test_decode_compact
        
        input = "\x0b\x4c\x05hello\x00\x01\x02\x03"
        
        message = @model.decode_compact(input)
        
        assert_equal("hello", message["Symbol"])
        assert_equal(0, message["OrderId"])
        assert_equal(1, message["Price"])
        assert_equal(2, message["Qty"])
        assert_equal(3, message["MatchId"])
        
    end


end
