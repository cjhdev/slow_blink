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

    module INTEGER

        module CLASS

            include SlowBlink::CompactEncoder

            def opt?
                @opt
            end

            def in_range?(value)
                @schema.class::RANGE.cover? value
            end

        end

        module INSTANCE

            include SlowBlink::CompactEncoder

            def set(value)
                if value
                    if value.kind_of? Integer
                        if self.class.in_range?(value)
                            @value = value.to_i
                        else
                            raise Error.new "value out of range"
                        end
                    else
                        raise Error.new "value must be an integer"
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

            # @param value [Integer, nil]
            def initialize(value)
                if value
                    set(value)
                else
                    @value = nil
                end
            end
        end
        
    end

    module U8

        module CLASS    
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getU8!(input))
            end
        end

        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putU8(@value)
            end
        end
        
    end

    module U16

        module CLASS
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getU16!(input))
            end
        end

        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putU16(@value)
            end
        end
    end

    module U32

        module CLASS            
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getU32!(input))
            end
        end

        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putU32(@value)
            end
        end
        
    end

    module U64

        module CLASS
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getU64!(input))
            end
        end

        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putU64(@value)
            end
        end
        
    end

    module I8

        module CLASS
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getI8!(input))
            end
        end

        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putI8(@value)
            end
        end
        
    end

    module I16
        module CLASS
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getI16!(input))
            end
        end

        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putI16(@value)
            end
        end
        
    end

    module I32

        module CLASS
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getI32!(input))
            end
        end

        module INSTANCE
            include INTEGER::INSTANCE
            def to_compact
                putI32(@value)
            end
        end
        
    end

    module I64

        module CLASS
            include SlowBlink::Message::INTEGER::CLASS
            def from_compact!(input)
                self.new(getI64!(input))
            end
        end
            
        module INSTANCE
            include SlowBlink::Message::INTEGER::INSTANCE
            def to_compact
                putI64(@value)
            end
        end
    end

end