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

require 'time'

module SlowBlink::Message

    class MILLI_TIME

        def self.from_compact!(input)
            value = input.getI64!
            if value
                self.new(value)
            else
                value
            end
        end

        def get
            @value
        end

        def set(value)            
            if value.kind_of? Time or value.kind_of? DateTime or value.kind_of? Date
                @value = time.to_datetime
            elsif value.kind_of? String
                @value = DateTime.parse(value)
            elsif value.kind_of? Integer
                @value = DateTime.new(value)
            else
                raise Error.new "unexpected type"
            end                        
        end

        def initialize(value)
            set(value)            
        end

        def to_compact(out)
            out.putI64(@value.strftime('%Q'))            
        end
    
    end

    class NANO_TIME < MILLI_TIME
        
        def to_compact(out)
            out.putI64(@value.strftime('%N'))
        end
        
    end

end
