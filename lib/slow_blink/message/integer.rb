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

module SlowBlink::Message

    module INTEGER

        def value=(v)
            if v
                if v.kind_of? Integer
                    if RANGE.cover? v
                        @value = v.to_i
                    else
                        raise Error.new "value out of range"
                    end
                else
                    raise Error.new "value must be an integer"
                end
            elsif self.class.opt?
                @value = nil
            else
                raise Error.new "value unacceptable"
            end
        end
        
        def value
            @value
        end

        def initialize(value)
            self.value = value
        end        
    end

    module U8
        RANGE = Range.new(0, 0xff)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getU8!(input))
        end
        def to_compact
            CompactEncoder::putU8(@value)
        end        
    end

    module U16
        RANGE = Range.new(0, 0xffff)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getU16!(input))
        end
        def to_compact
            CompactEncoder::putU16(@value)
        end        
    end

    module U32
        RANGE = Range.new(0, 0xffffffff)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getU32!(input))
        end
        def to_compact
            CompactEncoder::putU32(@value)
        end        
    end

    module U64
        RANGE = Range.new(0, 0xffffffffffffffff)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getU64!(input))
        end
        def to_compact
            CompactEncoder::putU64(@value)
        end        
    end

    module I8
        RANGE = Range.new(-128, 127)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getI8!(input))
        end
        def to_compact
            CompactEncoder::putI8(@value)
        end        
    end

    module I16
        RANGE = Range.new(-32768, 32767)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getI16!(input))
        end
        def to_compact
            CompactEncoder::putI16(@value)
        end        
    end

    module I32
        RANGE = Range.new(-2147483648, 2147483647)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getI32!(input))
        end
        def to_compact
            CompactEncoder::putI32(@value)
        end        
    end

    module I64
        RANGE = Range.new(-9223372036854775808, 9223372036854775807)
        include INTEGER
        def self.from_compact!(input)
            self.new(CompactEncoder::getI64!(input))
        end
        def to_compact
            CompactEncoder::putI64(@value)
        end        
    end

end
