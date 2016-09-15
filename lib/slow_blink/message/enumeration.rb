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

    class ENUMERATION

        # @return [Hash] symbol/value table
        def self.symbols
            @symbols
        end

        def self.from_compact!(input, stack)
            value = input.getU32!
            if value
                self.new(value)
            else
                value
            end            
        end

        def get
            @value
        end

        # Set a symbol
        # @param value [String] symbol in enumeration
        # @raise [RangeError] value is not valid symbol
        def set(value)
            if @symbols[value]
                @value = @symbols[value]
            else
                raise RangeError.new "symbol '#{value}' not defined in enumeration"
            end                    
        end        

        # @note calls {#set}(value)
        def initialize(value)
            @symbols = self.class.symbols
            set(value)
        end
        
        def to_compact(out)
            out.putU32(@value ? @symbols[@value] : nil)
        end
    
    end

end
