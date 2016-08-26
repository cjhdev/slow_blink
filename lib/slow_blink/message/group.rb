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

    module Group

        def self.from_compact!(input)
            fields = []
            @fields.each do |f|
                f.from_compact!(input)
            end
            self.new(fields)
        end

        def value=(v)
            if v
                if v.kind_of? Array
                    @value = v
                else
                    raise
                end
            elsif self.class.opt?
                @value = nil
            else
                raise
            end
        end

        def value
            @value
        end

        def initialize(value)
            self.value = value
        end

        def to_compact                
            @fields.each do |f|
                f.to_compact
            end
        end

        def initialize(fields)
            @fields = fields
        end

    end

    # a dynamic group has a few options for Groups or Dynamic Groups
    module DynamicGroup

        def self.from_compact!(input)
            groupBuf = CompactEncoder::getBinary(input)
            if groupBuf.size == 0
                raise Error.new "zero group"
            end
            type = CompactEncoder::getU64(input)
            group = @groups[type]
            if group
                group.new(groupBuf)
            else
                raise Error.new "do not recognise group"
            end
        end

        def to_compact
            if @value
                out = CompactEncoder::putU64(@id)
                @fields.each do |name, f|
                    out << f.to_compact(value)
                end
                CompactEncoder::putU32(out.size) + out
            else
                CompactEncoder::putU32(nil)
            end
        end

    end

end
