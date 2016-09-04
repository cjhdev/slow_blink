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

        module CLASS

            def from_compact!(input)
                self.new(input.get32!)
            end
        
        end

        module INSTANCE

            def set(value)
                if value
                    if value.kind_of? Integer
                        if value < 86400000
                            @value = value                            
                        else
                            raise Error.new "input out of range"
                        end
                    elsif value.kind_of? Time
                        @value = value.to_i
                    else
                        raise "what is this?"                        
                    end         
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

            # @private
            def to_compact(out)
                out.putU32(@value)
                
            
       
            end        
        
        end
    
    end

    module TIME_OF_DAY_NANO
    
        module CLASS
            
            def from_compact!(input)
                self.new(input.getU64!)
            end
            
        end

        module INSTANCE

        
            def set(value)
                if value
                    if value.kind_of? Integer
                        if value < 86400000000000
                            @value = value                            
                        else
                            raise Error.new "input out of range"
                        end
                    elsif value.kind_of? Time
                        @value = value.to_i
                    else
                        raise "what is this?"                        
                    end         
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

            # @private
            def to_compact(out)
                out.putU64(@value) 
            end        
        
        end
        
    end

end
