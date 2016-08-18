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

        # @macro common_to_s
        def to_s
            "#{self.class.name.split('::').last.downcase}"
        end

        # @macro common_link
        def link(schema, stack=[])
            @schema = schema
        end
    end

    # Blink Specification 3.2
    class STRING < Type
        attr_reader :size

        # @param size [Integer] maximum size
        def initialize(size)
            @size = size
        end

        # @macro common_to_s
        def to_s
            if @size
                "#{super} (#{@size})"
            else
                super
            end            
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
        def initialize(type)
            @type = type
        end

        # @macro common_to_s
        def to_s
            "#{@type} []"
        end
        
    end

    #
    # may be a:
    #
    # - Enumeration
    # - Group
    # - Dynamic Group
    # - Dynamic Object
    class REF < Type

        # @return [true] dynamic reference
        # @return [false] static reference
        def dynamic?
            @dynamic
        end

        # @param ref [String] 
        # @param dynamic [true,false]
        def initialize(ref, dynamic)
            @ref = ref
            @dynamic = dynamic
        end

        # @macro common_to_s
        def to_s
            if @dynamic
                "#{ref} *"
            else
                "#{ref}"
            end                
        end

        def value
            if @schema.nil?
                raise "must be linked"
            end
            @object
        end

        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                @schema = nil
                @object = schema.symbol(@ref)
                if @object
                    @schema = schema
                else
                    puts "ref '#{@ref}' is not defined"
                end                
            end
            @schema
        end
    end

    class OBJECT < Type        
    end

end


