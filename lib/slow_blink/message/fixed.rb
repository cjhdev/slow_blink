# @license
#   
#   Copyright (c) 2016 Cameron Harper
#    
#   Permission is hereby granted, free of charge, to any person obtaining a copy of
#   this software and associated documentation files (the "Software"), to deal in
#   the Software without restriction, including without limitation the rights to
#   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
#   the Software, and to permit persons to whom the Software is furnished to do so,
#   subject to the following conditions:
#   
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
# 
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
#   FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
#   COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module SlowBlink::Message

    # @abstract
    class FIXED

        def self.type
            @type
        end

        # @private
        def self.from_compact(input, depth)
            if value = input.getFixed(size)
                self.new(value)
            else                    
                nil
            end
        end

        # @return [Integer] size of fixed type in bytes
        def self.size
            @type.size
        end

        # @return [String]
        def get
            @value
        end

        # Set a fixed size type
        # @param value [String]
        # @raise [RangeError]
        # @raise [TypeError]
        def set(value)
            if value.kind_of? String
                if value.size == self.class.size
                    @value = value.to_s
                else
                    raise RangeError.new "String instance must have size of #{@size} bytes"
                end
            else
                raise TypeError.new "expecting a String instance"
            end
        end

        # @note calls {#set}(value)
        def initialize(value)
            set(value)                
        end

        # @private
        def to_compact(out)
            out.putFixed(@value)
        end

    end

end
