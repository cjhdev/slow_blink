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

    module TIME_OF_DAY_MILLI

        include SlowBlink::CompactEncoder

        module CLASS

            def from_compact!(input)
                self.new(getU32!(input))
            end
        
        end

        module INSTANCE

            def set(value)
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

            # @private
            def to_compact(input, **opts)
                if input.kind_of? Integer
                    if input < 86400000
                        putU32(input)
                    else
                        raise Error.new "input out of range"
                    end
                elsif input.kind_of? Time
                    putU32(input.to_i)
                elsif opts[:optional] and input.nil?
                    putU32(nil)
                else
                    raise Error.new "expecting time of day in milliseconds, got #{input}"
                end                
            end        
        
        end
    
    end

    module TIME_OF_DAY_NANO

        include SlowBlink::CompactEncoder

        module CLASS

            def from_compact!(input)
                self.new(getU32!(input))
            end
            
        end

        module INSTANCE

            def set(value)
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

            # @private
            def to_compact(input, **opts)
                if input.kind_of? Integer
                    if input < 86400000000000
                        putU64(input)
                    else
                        raise Error.new "input out of range"
                    end
                elsif input.kind_of? Time
                    putU64(input.to_i)
                elsif opts[:optional] and input.nil?
                    putU64(nil)
                else
                    raise Error.new "expecting time of day in nanoseconds, got #{input}"
                end                
            end        
        
        end
        
    end

end
