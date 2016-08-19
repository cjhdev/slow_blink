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

    class Type

        include Annotatable

        attr_reader :location

        # @param location [String]
        def initialize(location)
            @schema = nil
            @annotes = {}
            @location = location
        end

        # @macro common_link
        def link(schema, stack=[])
            @schema = schema
        end

    end

    # Blink Specification 3.2
    class STRING < Type

        # @return [Integer] maximum size
        # @return [nil] no maximum size
        attr_reader :size

        # @param size [Integer] maximum size
        # @param location [String]    
        def initialize(size, location)
            @size = size
            super(location)
        end
    end

    # Blink Specification 3.4
    class FIXED < STRING
    end

    # Blink Specification 3.3
    class BINARY < STRING
    end

    # Blink Specification 3.1
    class I8 < Type
    end

    # Blink Specification 3.1
    class I16 < Type
    end

    # Blink Specification 3.1
    class I32 < Type
    end

    # Blink Specification 3.1
    class I64 < Type
    end

    # Blink Specification 3.1
    class U8 < Type
    end

    # Blink Specification 3.1
    class U16 < Type
    end

    # Blink Specification 3.1
    class U32 < Type
    end

    # Blink Specification 3.1
    class U64 < Type
    end

    # Blink Specification 3.1
    class F64 < Type
    end

    # Blink Specification 3.6
    class BOOLEAN < Type
    end

    # Blink Specification 3.7
    class DECIMAL < Type
    end

    # Blink Specification 3.10
    class DATE < Type
    end

    # Blink Specification 3.9
    class NANO_TIME < Type
    end

    # Blink Specification 3.9
    class MILLI_TIME < Type
    end

    # Blink Specification 3.11
    class TIME_OF_DAY_NANO < Type
    end

    # Blink Specification 3.11
    class TIME_OF_DAY_MILLI < Type
    end

    # Blink Specification 3.12
    class SEQUENCE < Type

        # @return [Type]
        attr_reader :type

        # @param type [Type] repeating type
        # @param location [String]    
        def initialize(type, location)
            @type = type
            super(location)
        end

    end

    class REF < Type

        # @return [true] dynamic reference
        # @return [false] static reference
        def dynamic?
            @dynamic
        end

        # @param ref [String] 
        # @param dynamic [true,false]
        # @param location [String]    
        def initialize(ref, dynamic, location)
            @ref = ref
            @dynamic = dynamic
            super(location)
        end

        def value        
            if @schema
                @object
            else
                raise "must be linked"
            end            
        end

        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                @schema = nil
                @object = schema.symbol(@ref)
                if @object and @object.link(schema, stack << self)                    
                    @schema = schema
                else
                    puts "#{@location}: error: '#{@ref}' is not defined in schema"
                end                
            end
            @schema
        end
    end

    class OBJECT < Type        
    end

end


