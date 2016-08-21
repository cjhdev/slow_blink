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

        extend CompactEncoder
        include Annotatable

        # @param [String]
        attr_reader :location

        # @private
        #
        # @param location [String]
        def initialize(location)
            @schema = nil
            @annotes = {}
            @location = location
        end

        # @private
        #
        # @macro common_link
        def link(schema, stack=[])
            @schema = schema
        end

        def ===(other)
            self.class == other.class            
        end

    end

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
        def validate(value)
            if @schema and value.kind_of? String and value.size < @size
                true
            else
                raise
            end
        end

        # @private
        def encode_compact(value)
            putVLC(value.size) + value
        end
        
    end

    # Blink Specification 3.4
    class FIXED < STRING
        # @private
        def validate(value)
            if @schema and value.kind_of? String and value.size == @size
                true
            else
                raise
            end
        end

        # @private
        def encode_compact(value)
            value
        end
    end

    # Blink Specification 3.3
    class BINARY < STRING        
    end

    class INTEGER < Type

        # @private
        def validate(value)
            if @schema and value.kind_of? Integer and self.class::RANGE.include? value
                true
            else
                raise
            end
        end
        
    end

    # Blink Specification 3.1
    class I8 < INTEGER

        RANGE = Range.new(-128, 127)

        # @private
        def encode_compact(value)
            putVLC(value, signed: true)
        end
    end

    # Blink Specification 3.1
    class I16 < INTEGER

        RANGE = Range.new(-32768, 32767)

        # @private
        def encode_compact(value)
            putVLC(value, signed: true)
        end
    end

    # Blink Specification 3.1
    class I32 < INTEGER

        RANGE = Range.new(-2147483648, 2147483647)

        # @private
        def encode_compact(value)
            putVLC(value, signed: true)
        end
    end

    # Blink Specification 3.1
    class I64 < INTEGER

        RANGE = Range.new(-9223372036854775808, 9223372036854775807)

        # @private
        def encode_compact(value)
            putVLC(value, signed: true)
        end
    end

    # Blink Specification 3.1
    class U8 < INTEGER

        RANGE = Range.new(0, 0xff)

        # @private
        def encode_compact(value)
            putVLC(value)
        end
    end

    # Blink Specification 3.1
    class U16 < INTEGER

        RANGE = Range.new(0, 0xffff)

        # @private
        def encode_compact(value)
            putVLC(value)
        end
    end

    # Blink Specification 3.1
    class U32 < INTEGER

        RANGE = Range.new(0, 0xffffffff)

        # @private
        def encode_compact(value)
            putVLC(value)
        end
    end

    # Blink Specification 3.1
    class U64 < INTEGER

        RANGE = Range.new(0, 0xffffffffffffffff)

        # @private
        def encode_compact(value)
            putVLC(value)
        end
    end

    # Blink Specification 3.1
    class F64 < INTEGER

        # @private
        def encode_compact(value)
            putF64(value)
        end
    end

    # Blink Specification 3.6
    class BOOLEAN < Type

        # @private
        def encode_compact(value)
            putBool(value)            
        end
    end

    # Blink Specification 3.7
    class DECIMAL < Type
    end

    # Blink Specification 3.10
    class DATE < Type
    end

    # Blink Specification 3.9
    class NANO_TIME < Type

        # @private
        def validate(value)
            if value.kind_of? Time or value.kind_of? Integer
                true
            else
                raise
            end
        end
        
    end

    # Blink Specification 3.9
    class MILLI_TIME < Type

        # @private
        def validate(value)
            if value.kind_of? Time or value.kind_of? Integer
                true
            else
                raise
            end
        end
        
    end

    # Blink Specification 3.11
    class TIME_OF_DAY_NANO < Type

        # @private
        def validate(value)
            if value.kind_of? Time
                true
            elsif value.kind_of? Integer and value <= 86400000000000
                true
            else
                raise
            end                            
        end
        
    end

    # Blink Specification 3.11
    class TIME_OF_DAY_MILLI < Type

        # @private
        def validate(value)
            if value.kind_of? Time
                true
            elsif value.kind_of? Integer and value <= 86400000
                true
            else
                raise
            end                            
        end
        
    end

    # Blink Specification 3.12
    class SEQUENCE < Type

        # @return [Type]
        attr_reader :type

        # @private
        #
        # @param type [Type] repeating type
        # @param location [String]    
        def initialize(type, location)
            @type = nil
            @rawType = type
            super(location)
        end

        # @private
        #
        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                @schema = nil
                case @rawType.class
                when REF
                    schema.symbol(@rawType)
                when SEQUENCE
                    puts "error: sequence of sequence is not permitted"
                else
                    @type = @rawType
                    @schema = schema
                end
            end
            @schema
        end

        # @private
        def validate(value)
            if @schema and value.kind_of? Array                
                value.each do |v|
                    @type.validate(v)
                end
            else
                raise
            end
        end

        # @private
        def encode_compact(value)
            out = putVLC(value.size)
            value.each do |v|
                out << @type.encode_compact(v)
            end
            out    
        end

    end

    class REF < Type

        # @return [true] dynamic reference
        # @return [false] static reference
        def dynamic?
            @dynamic
        end

        # @private
        #
        # @param ref [String] 
        # @param dynamic [true,false]
        # @param location [String]    
        def initialize(ref, dynamic, location)
            @ref = ref
            @dynamic = dynamic
            @object = nil
            super(location)
        end

        def value        
            if @schema
                @object
            else
                raise "must be linked"
            end            
        end

        # @private
        # 
        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                @schema = nil
                ref = @ref
                object = schema.symbol(ref)
                if object and object.link(schema, stack << self)
                    # walk through all references until object
                    # refers to an actual type
                    loop do
                        if object.is_a? REF
                            object = object.object
                        else
                            break
                        end
                    end
                    if @dynamic and @object.class != Group
                        puts "#{@location}: error: '#{@ref} *' must resolve to a Group"
                    else                    
                        @object = object
                        @schema = schema
                    end
                else                    
                    puts "#{@location}: error: '#{@ref}' is not defined in schema"
                end                
            end
            @schema
        end

        # @private
        def validate(value)
            @object.validate(input)
        end

        # @private
        def encode_compact(value)
            @object.encode_compact(value, dynamic: @dynamic)            
        end
    end

    # any group
    #
    # Blink Specification 3.9
    class OBJECT < Type

        # @private
        def validate(value)
            if value.kind_of? Hash and value["$type"]

                group = @schema.group(value["$type"])
                if group
                    group.validate(value)
                else
                    raise
                end
            
            else
                raise
            end
        end

        # @private
        def encode_compact(value, **opts)
            @object.encode_compact(value, dynamic: true)            
        end
    end

end


