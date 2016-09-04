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

class TestModel < Test::Unit::TestCase

    include SlowBlink

    def test_think_blink
        rawSchema = <<-eos
        OrderExecuted/0x4c ->
            string Symbol,
            u64 OrderId,
            u32 Price,
            u32 Qty,
            u8 MatchId
        eos
        schema = Schema.new(SchemaBuffer.new(rawSchema))        
        model = Message::Model.new(schema)
    end

    def test_from_compact
        rawSchema = <<-eos
        OrderExecuted/0x4c ->
            string Symbol,
            u64 OrderId,
            u32 Price,
            u32 Qty,
            u8 MatchId
        eos
        schema = Schema.new(SchemaBuffer.new(rawSchema))
    
        input = "\x0b\x4c\x05hello\x00\x01\x02\x03"
        model = Message::Model.new(schema)
        
        message = model.decode_compact(input)
        
        assert_equal("hello", message["Symbol"])
        assert_equal(0, message["OrderId"])
        assert_equal(1, message["Price"])
        assert_equal(2, message["Qty"])
        assert_equal(3, message["MatchId"])        
    end



end
