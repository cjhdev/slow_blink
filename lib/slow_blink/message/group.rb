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

        def value=(v)
            if v
                if v.kind_of? Hash
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
    end

    module DynamicGroup

        def self.from_compact!(input)
            groupBuf = CompactEncoder::getBinary(input)
            if groupBuf.size == 0
                raise Error.new "W1"    # size of zero
            end
            type = CompactEncoder::getU64(input)                    
            group = self.groups[type]
            if group
                fields = {"$type".freeze => self.name}
                group.fields.each do |f|
                    newField = f.from_compact!(input)
                    fields[newField.name] << newField
                end
                self.new(fields)
            else
                raise Error.new "W2"    # type identifier not know to decoder
            end            
        end

        def to_compact
             if @value
                out = @fields.inject(CompactEncoder::putU64(@id)) do |acc, f|
                    acc << f.to_compact(value)
                end
                CompactEncoder::putU32(out.size) + out
            else
                CompactEncoder::putU32(nil)
            end
        end

    end

    module StaticGroup

        def self.from_compact!(input)
            fields = {"$type".freeze => self.name}
            if self.opt?
                if CompactEncoder::getPresent!(input)
                    self.fields.each do |f|
                        newField = f.from_compact!(input)
                        fields[newField.name] << newField
                    end
                    self.new(fields)
                else
                    self.new(nil)
                end
            else
                self.fields.each do |f|
                    newField = f.from_compact!(input)
                    fields[newField.name] << newField
                end
                self.new(fields)
            end            
        end

        def to_compact
            if @value
                if self.class.opt?
                    @fields.inject(CompactEncoder::putPresent(true)) do |acc, f|
                        acc << f.to_compact(value)
                    end
                else
                    @fields.inject("") do |acc, f|
                        acc << f.to_compact(value)
                    end
                end
            else
                CompactEncoder::putPresent(false)
            end
        end

    end

end
