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

    def setup
        rawSchema = <<-eos
        OrderExecuted/0x4c ->
            string Symbol,
            u64 OrderId,
            u32 Price,
            u32 Qty,
            u32 MatchId
        eos
        @schema = Schema.new(SchemaBuffer.new(rawSchema))
    end

    def test_init        
        model = Message::Model.new(@schema)
    end

    def test_from_compact
        input = "\x0b\x4c\x05hello\x00\x01\x02\x03"
        model = Message::Model.new(@schema)
        message = model.from_compact(input)
        assert_equal("hello", message.field("Symbol").get)
        assert_equal(0, message.field("OrderId").get)
        assert_equal(1, message.field("Price").get)
        assert_equal(2, message.field("Qty").get)
        assert_equal(3, message.field("MatchId").get)        
    end

=begin
    def test_new
        model = Message::Model.new(@schema)        
        message = model.new do
            group "OrderExecuted" do
                field("Symbol").set "hey"
                field("OrderId").set 42
                field("Price").set [
                    group "OrderExecuted" { field("hey").set "heyhey" }
                    group "OrderExecuted" { field("hey").set "heyhey" }
                    group "OrderExecuted" { field("hey").set "heyhey" }
                ]                       
            end
        end
        
    end
=end    

end
