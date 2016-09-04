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

    module STRING

        module CLASS

            def name
                @name
            end

            def opt?
                @opt
            end

            def from_compact!(input)
                value = input.getString!
                if value
                    if !@type.size or value.size <= @type.size
                        self.new(value)
                    else
                        raise Error.new "W7: String value exceeds maximum size"
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

            def get
                @value
            end

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

            def initialize(value)
                if value
                    set(value)
                else
                    @value = nil
                end
            end

            def to_compact(out)
                out.putString(@value)
            end

        end
        
    end

end
