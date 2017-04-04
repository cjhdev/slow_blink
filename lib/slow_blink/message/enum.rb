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
    class ENUM

        def self.type
            @type             
        end

        # @private
        def self.from_compact(input, depth)
            if value = input.getI32
                if symbol = type.symbol(value)
                    self.new(symbol.name)
                else
                    raise WeakError10.new "W10: value '#{value}' does not correspond to any symbol in enumeration"
                end
            else
                nil
            end            
        end

        # @return [String]
        def get
            @value
        end

        # Set a symbol
        # @param value [String] symbol in enumeration
        # @raise [RangeError] value is not valid symbol
        def set(value)
            if value.kind_of? String
                if self.class.type.symbol(value)
                    @value = value.to_s
                else
                    raise RangeError.new "symbol '#{value}' not defined in enumeration"
                end
            else
                raise TypeError.new "value must be a String"
            end              
        end        

        # @note calls {#set}(value)
        def initialize(value)
            set(value)
        end

        # @private
        def to_compact(out)
            out.putI32(self.class.type.symbol(@value).value)            
        end

        def to_tag
            @value
        end
    
    end

end
