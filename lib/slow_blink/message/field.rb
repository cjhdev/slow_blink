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
    class Field
        
        # @return [true,false] field is optional?
        def self.optional?
            @optional
        end

        # @return [String] field name
        def self.name
            @name.to_s
        end

        # @return [Integer,nil] field ID
        def self.id
            @id
        end

        # @return [Object] type contained by field
        def self.type
            @type
        end

        # @return [true,false] true if this field contains a sequence type
        def self.sequence?
            @sequence
        end

        # @private
        # @param input [String] Blink compact form
        # @param stack [Array]
        # @return [Field] instance of anonymous subclass of Field
        def self.from_compact(input, stack)
            if sequence?
                if size = input.getU32
                    value = []
                    while value.size < size do
                        value << @type.from_compact(input, stack).get
                    end
                    self.new(value)
                else
                    nil
                end
            elsif optional? and (type.kind_of? StaticGroup or type.kind_of? FIXED)
                if input.get_present(input)
                    self.new(@type.from_compact(input, stack).get)
                else
                    nil
                end
            else
                self.new(@type.from_compact(input, stack).get)
            end
        end

        # @note calls {#set}(value)
        def initialize(value)

            @optional = self.class.optional?
            @sequence = self.class.sequence?
            @type = self.class.type

            if value
                set(value)
            else
                @value = nil
            end
                        
        end
        
        def set(value)
            if value.nil?
                if optional?
                    @value = nil
                else
                    raise ArgumentError.new "field is not optional, value cannot be nil"
                end                
            elsif self.class.sequence?                
                if value.kind_of? Array
                    @value = []
                    value.each do |v|
                        @value << @type.new(v)
                    end
                else
                    raise ArgumentError.new "field value must be an array of type"
                end
            else
                @value = @type.new(value)
            end
        end

        # @return field value or nil
        def get
            if @value
                if self.class.sequence?
                    @value.map{|v|v.get}                
                else
                    @value.get
                end
            else
                nil
            end
        end

        # @private
        # @param out [StringIO]
        # @return [StringIO]
        def to_compact(out)
            if @value
                if self.class.sequence?
                    out.putU32(@value.size)
                    @value.each do |v|
                        v.to_compact(out)
                    end
                else
                    if self.class.optional? and (self.type.kind_of? StaticGroup or self.type.kind_of? FIXED)
                        out.putPresent
                    end
                    @value.to_compact(out)
                end
            elsif @optional
                out.putNull
            else
                raise IncompleteGroup.new "'#{self.name}' must not be null"
            end
        end

        private

            def sequenceOfSameType(value)
                value.each do ||
                end
            end

    end

end
