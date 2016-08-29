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

    module MILLI_TIME

        

        module CLASS

            include SlowBlink::CompactEncoder

            def from_compact!(input)
                self.new(getI64(input))
            end

        end

        module INSTANCE

            include SlowBlink::CompactEncoder

            def set(value)
                if value
                    raise
                elsif self.class.opt?
                    @value = nil
                else
                    raise 
                end
            end

            def get
                @value
            end

            def initialize(value)
                if value
                    set(value)
                else
                    @value = nil
                end
            end

            def to_compact
                putI64(@value)
            end

        end
    
    end

    module NANO_TIME

        
        module CLASS
            include SlowBlink::CompactEncoder
            include SlowBlink::Message::MILLI_TIME::CLASS
        end

        module INSTANCE
            include SlowBlink::CompactEncoder
            include SlowBlink::Message::MILLI_TIME::INSTANCE
        end
    
    end

end