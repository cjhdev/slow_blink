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
    class FLOATING_POINT

        # @private
        def self.from_compact!(input, stack)
            value = input.getF64!
            if value
                self.new(value)
            else
                value
            end
        end

        # @return [Numeric]
        def get
            @value
        end

        # @param value [Numeric]
        # @raise [TypeError]
        def set(value)
            if value.kind_of? Numeric
                @value = value.to_f
            else
                raise TypeError.new "expecting an instance of Numeric"
            end
        end

        # @note calls {#set}(value)
        def initialize(value)
            set(value)
        end

        # @private
        def to_compact(out)
            out.putF64(@value)
        end

    end

end
