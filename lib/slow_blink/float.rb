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

    # Blink Specification 3.1
    class F64 < INTEGER

        # @private
        def to_compact(input, **opts)
            if input.kind_of? Numeric
                CompactEncoder::putF64(input.to_f)
            elsif opts[:optional] and input.nil?
                CompactEncoder::putF64(nil)
            else
                raise "expecting float, got #{input}"
            end
        end

        # @private
        #
        # @param input [String] binary string to consume
        # @return [nil] NULL encoded input
        # @return [Float]
        # @raise [Error] soft or hard error encountered        
        def from_compact!(input, **opts)
            CompactEncoder::getF64!(input)
        end
    end

end
