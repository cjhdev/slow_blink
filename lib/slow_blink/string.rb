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

    # Blink Specification 3.2
    class STRING < Type

        # @return [Integer] maximum size
        # @return [nil] no maximum size
        attr_reader :size

        # @private
        #
        # @param size [Integer] maximum size
        # @param location [String]    
        def initialize(size, location)
            @size = size
            super(location)
        end

        # @private
        def to_compact(input, **opts)            
            if input.kind_of? String
                if @size.nil? or input.size <= @size
                    CompactEncoder::putString(input)
                else
                    raise Error.new "string is '#{input.size}' bytes long but the constraint is '{@size}' bytes long"
                end
            elsif opts[:optional] and input.nil?
                CompactEncoder::putString(input)
            else
                raise Error.new "expecting a string, got a '#{input.class}'"
            end
        end

        def from_compact!(input, **opts)
            out = CompactEncoder::getString!(input)
            if !opts[:optional] and out.nil?
                raise Error.new "field must be present"
            elsif out and @size and out.size > @size
                raise Error.new "W7"
            else
                out
            end                                    
        end
        
    end

end
