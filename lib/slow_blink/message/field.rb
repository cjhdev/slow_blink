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

    class Field
        
        # @return [true,false] field is optional?
        def self.opt?
            @opt
        end

        # @return [String] field name
        def self.name
            @name
        end

        # @return [Integer,nil] field ID
        def self.id
            @id
        end

        # @return [Object] type contained by field
        def self.type
            @type
        end

        # @param input [String] Blink compact form
        # @param [Field] instance of anonymous subclass of Field
        def self.from_compact!(input)        
            self.new(@type.from_compact!(input))
        end

        def initialize(value)
            @opt = self.class.opt?
            @type = self.class.type
            if value.is_a? self.class.type
                @value = value
            elsif value
                @value = self.class.type.new(value)
            else
                @value = nil
            end
        end

        def set(value)
            if value
                if value.is_a? self.class.type
                    @value = value                    
                elsif @value                
                    @value.set(value)
                else
                    @value = self.class.type.new(value)                
                end
            elsif @opt
                @value = nil
            else
                raise Error.new "field can not be set to null"
            end            
        end

        # @return [Object]
        def get
            if @value
                @value.get
            else
                nil
            end
        end

        # @param out [String] output appended to this string
        # @return [String]
        def to_compact(out)
            if @value
                @value.to_compact(out)
            elsif @opt
                out.putNull
            else
                raise Error.new "field '#{self.name}' must not be null"
            end
        end

    end

end
