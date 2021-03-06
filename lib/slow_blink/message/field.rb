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
        # @param depth [Array]
        # @return [Field] instance of anonymous subclass of Field
        def self.from_compact(input, depth)
            self.new(input, depth)         
        end

        attr_reader :type
        
        def sequence?
            @sequence
        end
        def optional?
            @optional
        end

        def initialize(input=nil, depth=nil)

            @optional = self.class.optional?
            @sequence = self.class.sequence?
            @type = self.class.type
            @value = nil

            if input and depth
                if @sequence
                    if size = input.getU32
                        @value = []
                        size.times do
                            value = @type.from_compact(input, depth)
                            if value
                                @value << value
                            end
                        end
                    end
                elsif @optional and (@type.kind_of? StaticGroup or @type.kind_of? FIXED)
                    if input.get_present
                        @value = @type.from_compact(input, depth)
                    end
                else
                    @value = @type.from_compact(input, depth)
                end
                
            end
            
        end
        
        def set(value)            
            if value.kind_of? Field
                self.set(value.get)
            elsif value.nil?
                if @optional
                    @value = nil
                    self
                else
                    raise ArgumentError.new "field '#{self.class.name}'is not optional, value cannot be nil (sequence: #{@sequence})"
                end                
            elsif @sequence                
                if value.kind_of? Array
                    @value = []
                    value.each do |v|
                        if v.nil?
                            next
                        end
                        @value << @type.new(v)
                    end
                    self
                else
                    raise ArgumentError.new "field value must be an array of type"
                end
            else
                @value = @type.new(value)
                self
            end    
        end

        # @return field value or nil
        def get
            if @value
                if @sequence
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
                if @sequence
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
                raise IncompleteGroup.new "'#{self.class.name}' must not be null"
            end
        end

        def to_tag
            if @value
                if @value.is_a? Array
                    @value.inject("|#{self.class.name}=[") do |out,v|
                        if @value.first != v
                            out << ";"
                        end
                        out << v.to_tag
                    end << "]"
                else
                    "|#{self.class.name}=#{@value.to_tag}"
                end                
            else
                ""
            end
        end

    end

end
