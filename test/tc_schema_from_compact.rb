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

class TestSchemaFromCompact < Test::Unit::TestCase

    include SlowBlink

    def test_decode_u8

        schema = Schema.parse("test/0 -> u8 field")
        compact = "\x02\x00\x2a"        
        data = [{"$type" => "test", "field" => 42}]

        output = schema.from_compact(compact)
        assert_equal(data, output)
        
    end
    def test_decode_integers

        schema = Schema.parse("test/0 -> u8 \\u8, u16 \\u16, u32 \\u32")
        compact = "\x04\x00\x2a\x2a\x2a"
        data = [{"$type" => "test", "\\u8" => 42, "\\u16" => 42, "\\u32" => 42}]

        output = schema.from_compact(compact)
        assert_equal(data, output)        
    end
    def test_decode_string

        schema = Schema.parse("test/0 -> string \\string")
        compact = "\x0d\x00\x0bhello world"
        data = [{"$type" => "test", "\\string" => "hello world"}]
        
        output = schema.from_compact(compact)
        assert_equal(data, output)        
        
    end
    def test_decode_binary

        schema = Schema.parse("test/0 -> binary \\binary")
        compact = "\x0d\x00\x0bhello world"
        data = [{"$type" => "test", "\\binary" => "hello world"}]
        
        output = schema.from_compact(compact)
        assert_equal(data, output)                
        
    end
    def test_decode_enum
        schema = Schema.parse("colour = red | green | blue test/0 -> colour f1, colour f2, colour f3")
        compact = "\x04\x00\x00\x01\x02"
        data = [{"$type" => "test", "f1" => "red", "f2" => "green", "f3" => "blue"}]
        
        output = schema.from_compact(compact)
        assert_equal(data, output)                
    end
    def test_decode_sequence
        schema = Schema.parse("colour = red | green | blue test/0 -> u8 [] f1")
        compact = "\x07\x00\x05\x01\x02\x03\x04\x05"
        data = [{"$type" => "test", "f1" => [1,2,3,4,5]}]
        
        output = schema.from_compact(compact)
        assert_equal(data, output)                
    end

end
