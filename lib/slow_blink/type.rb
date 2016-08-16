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
        def to_s
            "#{self.class.name.downcase}"
        end
        def link(schema, stack=[])
            schema
        end
    end

    class STRING < Type
        attr_reader :size
        # @param size [Integer] maximum size
        def initialize(size)
            @size = size
        end
        def to_s
            if @size
                "#{super} (#{@size})"
            else
                super
            end            
        end
    end

    class FIXED < STRING
    end

    class BINARY < STRING
    end

    class I8 < Type
    end

    class I16 < Type
    end

    class I32 < Type
    end

    class I64 < Type
    end

    class U8 < Type
    end

    class U16 < Type
    end

    class U32 < Type
    end

    class U64 < Type
    end

    class F64 < Type
    end

    class BOOLEAN < Type
    end

    class DECIMAL < Type
    end

    class FIXED < Type
    end

    class DATE < Type
    end

    class NANO_TIME < Type
    end

    class MILLI_TIME < Type
    end

    class TIME_OF_DAY_NANO < Type
    end

    class TIME_OF_DAY_MILLI < Type
    end

    class SEQUENCE < Type
        attr_reader :type
        def initialize(type)
            @type = type
        end
    end

    # may be a:
    #
    # - Enumeration
    # - Group
    # - Dynamic Group
    # - Dynamic Object
    class REF < Type
        def dynamic?
            @dynamic
        end
        def initialize(qName, dynamic)
            @qName = qName.to_s
            @dynamic = dynamic
        end
        def to_s
            @qName
        end
        def link(schema, stack=[])
        end
    end

    class OBJECT < Type        
    end

end


