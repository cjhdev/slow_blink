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

class TestModelExtension < Test::Unit::TestCase

    include SlowBlink

    def setup

        rawSchema = <<-eos
        StaticGroup ->
            string one,
            u8 two,
            u8 three
            
        Test/0x00 ->
            string one,
            u8 two,
            u8 three,
            StaticGroup four            
        eos

        schema = Schema.new(SchemaBuffer.new(rawSchema))
        @model = Message::Model.new(schema)
        
    end

    def test_init

        message = @model.group("Test").new(
            "one" => "hello",
            "two" => 42,
            "three" => 42,
            "four" => {
                "one" => "world",
                "two" => 42,
                "three" => 42
            }
        )

        message.extension << @model.group("Test").new(
            "one" => "hello",
            "two" => 42,
            "three" => 42,
            "four" => {
                "one" => "world",
                "two" => 42,
                "three" => 42
            }
        )
            
        assert_equal("hello", message["one"])
        assert_equal(42, message["two"])
        assert_equal(42, message["three"])
        assert_equal("world", message["four"]["one"])
        assert_equal(42, message["four"]["two"])        
        assert_equal(42, message["four"]["three"])

        assert_equal(1, message.extension.size)
        assert_equal("hello", message.extension.first["one"])
        assert_equal(42, message.extension.first["two"])
        assert_equal(42, message.extension.first["three"])
        assert_equal("world", message.extension.first["four"]["one"])
        assert_equal(42, message.extension.first["four"]["two"])        
        assert_equal(42, message.extension.first["four"]["three"])
          
    end

    def test_encode_compact

        message = @model.group("Test").new(
            "one" => "hello",
            "two" => 42,
            "three" => 42,
            "four" => {
                "one" => "world",
                "two" => 42,
                "three" => 42
            }
        )

        message.extension << @model.group("Test").new(
            "one" => "hello",
            "two" => 42,
            "three" => 42,
            "four" => {
                "one" => "world",
                "two" => 42,
                "three" => 42
            }
        )

        output = message.encode_compact
        
        expected = "\x24\x00\x05hello\x2a\x2a\x05world\x2a\x2a\x01\x11\x00\x05hello\x2a\x2a\x05world\x2a\x2a"

        assert_equal(expected, output)
        
    end

    def test_decode_compact

        input = "\x24\x00\x05hello\x2a\x2a\x05world\x2a\x2a\x01\x11\x00\x05hello\x2a\x2a\x05world\x2a\x2a"

        message = @model.decode_compact(input)

        assert_equal("hello", message["one"])
        assert_equal(42, message["two"])
        assert_equal(42, message["three"])
        assert_equal("world", message["four"]["one"])
        assert_equal(42, message["four"]["two"])        
        assert_equal(42, message["four"]["three"])

        assert_equal(1, message.extension.size)
        assert_equal("hello", message.extension.first["one"])
        assert_equal(42, message.extension.first["two"])
        assert_equal(42, message.extension.first["three"])
        assert_equal("world", message.extension.first["four"]["one"])
        assert_equal(42, message.extension.first["four"]["two"])        
        assert_equal(42, message.extension.first["four"]["three"])
    
    end

end
