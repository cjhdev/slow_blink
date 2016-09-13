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

    class SEQUENCE

        def self.type
            @type
        end
            
        def self.from_compact!(input)
            value = []
            size = input.getU32!
            if size
                while out.size < size do
                    value << @type.from_compact!(input)
                end
                self.new(value)
            else
                nil
            end
        end

        def get
            @value
        end

        def set(value)
            @value = []
            if value.kind_of? Array
                value.each do |v|
                    if v.kind_of? self.class.type
                        @value << v
                    else
                        @value << self.class.type.new(v)
                    end
                end
            else
                raise Error.new "expecting an array"
            end
        end

        # @param value [Array<Object>]
        def initialize(value)
            @value = []            
            set(value)            
        end

        def to_compact(out)
            out.putU32(@value.size)
            @value.each do |value|                                
                value.to_compact(out)
            end            
        end

    end

end
