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

module SlowBlink

    class INTEGER < Type

        # @private
        def validate_json(input)
            if input.kind_of?(Integer)
                if self.class::RANGE.include?(input)
                    true
                else
                    raise Error.new "Integer value #{input} is out of Range  #{self.class::RANGE}"
                end                   
            else
                raise Error.new "expecting Integer"
            end
        end
        
    end

        # Blink Specification 3.1
    class I8 < INTEGER

        RANGE = Range.new(-128, 127)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putI8(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getI8!(input)
        end
    end

    # Blink Specification 3.1
    class I16 < INTEGER

        RANGE = Range.new(-32768, 32767)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putI16(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getI16!(input)
        end
    end

    # Blink Specification 3.1
    class I32 < INTEGER

        RANGE = Range.new(-2147483648, 2147483647)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putI32(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getI32!(input)
        end
    end

    # Blink Specification 3.1
    class I64 < INTEGER

        RANGE = Range.new(-9223372036854775808, 9223372036854775807)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putI64(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getI32!(input)
        end
    end

    # Blink Specification 3.1
    class U8 < INTEGER

        RANGE = Range.new(0, 0xff)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putU8(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getU8!(input)
        end
    end

    # Blink Specification 3.1
    class U16 < INTEGER

        RANGE = Range.new(0, 0xffff)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putU16(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getU16!(input)
        end
    end

    # Blink Specification 3.1
    class U32 < INTEGER

        RANGE = Range.new(0, 0xffffffff)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putU32(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getU32!(input)
        end
    end

    # Blink Specification 3.1
    class U64 < INTEGER

        RANGE = Range.new(0, 0xffffffffffffffff)

        # @private
        def to_compact(input, **opts)
            CompactEncoder::putU64(input)        
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Integer]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getU64!(input)
        end
    end

end
