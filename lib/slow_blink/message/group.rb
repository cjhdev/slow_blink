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

    module StaticGroup

        

        module CLASS

            include SlowBlink::CompactEncoder

            def fields
                @fields
            end

            def opt?
                @opt
            end

            def from_compact!(input)
                fields = {"$type".freeze => @name}
                if @opt
                    if getPresent!(input)
                        @fields.each do |f|
                            fields[f.name] = f.from_compact!(input)
                        end
                        self.new(fields)
                    else
                        self.new(nil)
                    end
                else
                    @fields.each do |f|                        
                        fields[f.name] = f.from_compact!(input)
                    end
                    self.new(fields)
                end            
            end

        end

        module INSTANCE

            include SlowBlink::CompactEncoder

            def set(value)
                if value
                    if value.kind_of? Hash
                        @value = value
                    else
                        raise
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

            def initialize(fields)
                if fields
                    set(fields)            
                else
                    @value = {}
                    self.class.fields.each do |f|
                        @value[f.name] = f.type.new(nil)
                    end                
                end                
            end

            def field(name)
                @value[name]
            end

            def to_compact
                if @value
                    if self.class.opt?
                        @fields.inject(putPresent(true)) do |acc, f|
                            acc << f.to_compact
                        end
                    else
                        @value.inject("") do |out, f|
                            out << f.to_compact
                        end
                    end
                else
                    putPresent(false)
                end
            end

        end

    end

    # methods that act on a dynamic group class
    module DynamicGroupClass

        include SlowBlink::CompactEncoder

        def groups
            @groups
        end

        def permitted
            @permitted
        end

        def group(id)
            if @permitted.include? id
                @groups[id]
            end
        end

        def from_compact!(input)
            groupBuf = getBinary(input)
            if groupBuf.size == 0
                raise Error.new "W1"    # size of zero
            end
            group = self.group(getU64(input))
            if group
                self.new(group.from_compact!(groupBuf))
            else
                raise Error.new "W2"    # type identifier not know to decoder
            end            
        end

    end

end
