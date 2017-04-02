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
    class BOOLEAN

        # @private
        def self.from_compact(input, depth)
            if value = input.getBool
                self.new(value)
            else
                nil
            end
        end

        # @return [TrueClass,FalseClass]
        def get
            @value
        end

        # Set a boolean value
        # @param value [TrueClass,FalseClass]
        # @raise [TypeError] value must be literally TrueClass or FalseClass
        def set(value)
            if value.kind_of? TrueClass or value.kind_of? FalseClass
                @value = value
            else
                raise TypeError.new "expecting true/false"
            end
        end

        # @note calls {#set}(value)
        def initialize(value)
            set(value)                
        end

        # @private
        def to_compact(out)
            out.putBool(@value)
        end
        
    end

end
