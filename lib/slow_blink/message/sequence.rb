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

    module SEQUENCE

        module CLASS
        
            def from_compact!(input)
                value = []
                size = input.getU32!
                if size
                    while out.size < size do
                        value << @type.from_compact!(input)
                    end
                    self.new(value)
                else
                    self.new
                end
            end

        end

        module INSTANCE

            # @param v [Array,nil]
            def set(value)
                if value
                    if value.kind_of? Array
                        @value = v
                    else
                        raise Error.new "bad type"
                    end
                elsif self.class.opt?
                    @value = nil
                else
                    raise Error.new "value unacceptable"
                end
            end

            def get
                @value
            end

            # @param value [Array]
            def initialize(value)
                if value
                    set(value)
                else
                    @value = nil
                end
            end

            def to_compact(out)
                if @value                
                    @value.inject(out.putU32(@value.size)) do |out, v|
                        out << v.to_compact
                    end
                else
                    out.putU32(nil)
                end                
            end

        end

    end

end
