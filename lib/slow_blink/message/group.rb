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

        include SlowBlink::CompactEncoder

        module CLASS

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

            def fields=(v)
                if v
                    if v.kind_of? Hash
                        @fields = v
                    else
                        raise
                    end
                elsif self.class.opt?
                    @fields = nil
                else
                    raise
                end
            end

            def fields
                @fields
            end

=begin
            def initialize
                @fields = {}
                self.class.fields.each do |f|
                    @fields[f.nameWithID.name] = f.new
                end
            end
=end            

            def initialize(fields)
                if fields.nil?
                    @fields = {}
                else
                    self.fields = fields
                end                
            end

            def field(name)
                @fields[name].value
            end

            def [](name)
                @fields[name].value
            end
            def []=(name, value)
                @fields[name].value = value
            end
            
            def to_compact
                if @value
                    if self.class.opt?
                        @fields.inject(putPresent(true)) do |acc, f|
                            acc << f.to_compact(value)
                        end
                    else
                        @fields.inject("") do |acc, f|
                            acc << f.to_compact(value)
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
