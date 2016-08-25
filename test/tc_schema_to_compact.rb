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

class TestSchemaToCompact < Test::Unit::TestCase

    include SlowBlink

    def test_encode_u8

        schema = Schema.parse("test/0 -> u8 field")
        data = {"$type" => "test", "field" => 42}
        compact = schema.to_compact(data)

        assert_equal("\x02\x00\x2a", compact)
        
    end
    def test_encode_integers

        schema = Schema.parse("test/0 -> u8 \\u8, u16 \\u16, u32 \\u32")
        data = {"$type" => "test", "\\u8" => 42, "\\u16" => 42, "\\u32" => 42}
        compact = schema.to_compact(data)

        assert_equal("\x04\x00\x2a\x2a\x2a", compact)
        
    end
    def test_encode_string

        schema = Schema.parse("test/0 -> string \\string")
        data = {"$type" => "test", "\\string" => "hello world"}
        compact = schema.to_compact(data)

        assert_equal("\x0d\x00\x0bhello world", compact)
        
    end
    def test_encode_binary

        schema = Schema.parse("test/0 -> binary \\binary")
        data = {"$type" => "test", "\\binary" => "hello world"}
        compact = schema.to_compact(data)

        assert_equal("\x0d\x00\x0bhello world", compact)
        
    end
    def test_encode_enum
        schema = Schema.parse("colour = red | green | blue test/0 -> colour f1, colour f2, colour f3")
        data = {"$type" => "test", "f1" => "red", "f2" => "green", "f3" => "blue"}
        compact = schema.to_compact(data)

        assert_equal("\x04\x00\x00\x01\x02", compact)
    end
    def test_encode_sequence
        schema = Schema.parse("colour = red | green | blue test/0 -> u8 [] f1")
        data = {"$type" => "test", "f1" => [1,2,3,4,5]}
        compact = schema.to_compact(data)

        assert_equal("\x07\x00\x05\x01\x02\x03\x04\x05", compact)
    end
    
end
