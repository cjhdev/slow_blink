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

    def test_set_individual

        message = @model.group "OrderExecuted" do |g|
            g["Symbol"] = "hey"
            g["OrderId"] = 42 
            g["Price"] = 42 
            g["Qty"] = 42 
            g["MatchId"] = 42                
        end            
        
        assert_equal("hey", message["Symbol"])
        assert_equal(42, message["OrderId"])
        assert_equal(42, message["Price"])
        assert_equal(42, message["Qty"])
        assert_equal(42, message["MatchId"])        
    
    end

    def test_set_bulk

        message = @model.group "OrderExecuted", {
            "Symbol" => "hey",
            "OrderId" => 42, 
            "Price" => 42, 
            "Qty" => 42, 
            "MatchId" => 42                
        }   
        

        assert_equal("hey", message["Symbol"])
        assert_equal(42, message["OrderId"])
        assert_equal(42, message["Price"])
        assert_equal(42, message["Qty"])
        assert_equal(42, message["MatchId"])        
    
    end

    def test_encode_compact
        
        message = @model.group "OrderExecuted" do |g|
            g["Symbol"] = "hey"
            g["OrderId"] = 42 
            g["Price"] = 42 
            g["Qty"] = 42 
            g["MatchId"] = 42                
        end            

        output = message.to_compact
        
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
