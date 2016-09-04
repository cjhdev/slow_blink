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

    module BINARY

        module CLASS

            def opt?
                @opt
            end

            def from_compact!(input)
                value = input.getBinary!
                if value
                    if !@size or value.size <= @size
                        self.new(value)
                    else
                        raise Error.new "W8: Binary value exceeds maximum size"
                    end
                elsif @opt
                    self.new(nil)
                else
                    raise Error.new "W5: Value cannot be null"
                end
            end

            def size
                @type.size
            end

        end

        module INSTANCE

            def set(value)
                if value
                    if value.kind_of? String
                        if !self.class.size or value.size <= self.class.size
                            @value = value
                        else
                            raise Error.new "string cannot be larger than #{self.class.size} bytes"
                        end
                    else
                        raise Error.new "expecting a string type"
                    end
                elsif self.class.opt?
                    @value = nil
                else
                    raise Error.new "string cannot be null"
                end
            end

            def get
                @value
            end

            def initialize(value)
                set(value)                
            end

            def to_compact(out)
                out.putBinary(@value)
            end

        end
        
    end

end
