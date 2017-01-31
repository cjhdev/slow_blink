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
    class INTEGER

        # @param value [Integer]
        # @return [true,false] integer value is within permitted range
        def self.in_range?(value)
            @type.class::RANGE.cover? value
        end

        # @return [Integer]
        def get
            @value
        end
        
        # Set an Integer value
        # @param value [Integer]
        # @raise [RangeError] value is outside of range according to {::in_range?}
        # @raise [TypeError]
        def set(value)
            if value.kind_of? Integer
                if self.class.in_range?(value)
                    @value = value.to_i
                else
                    raise RangeError.new
                end
            else
                raise TypeError.new "value must be an integer"
            end            
        end

        # @note calls {#set}(value)
        def initialize(value)        
            set(value)
        end

    end

    # @abstract
    class U8 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getU8
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putU8(@value)
        end        
        
    end

    # @abstract
    class U16 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getU16
                self.new(value)
            else
                nil
            end
        end
        
        # @private
        def to_compact(out)
            out.putU16(@value)
        end
        
    end

    # @abstract
    class U32 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getU32
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putU32(@value)
        end
        
    end

    # @abstract
    class U64 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getU64
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putU64(@value)
        end
        
    end

    # @abstract
    class I8 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getI8
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putI8(@value)
        end
        
    end

    # @abstract
    class I16 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getI16
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putI16(@value)
        end
        
    end

    # @abstract
    class I32 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getI32
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putI32(@value)
        end
        
    end

    # @abstract
    class I64 < INTEGER

        # @private
        def self.from_compact(input, stack)
            if value = input.getI64
                self.new(value)
            else
                nil
            end
        end

        # @private
        def to_compact(out)
            out.putI64(@value)
        end
        
    end

end
