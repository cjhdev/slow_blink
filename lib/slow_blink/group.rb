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

module SlowBlink

    class Group

        include Annotatable

        attr_reader :name
        
        # @param name [String] [\\]?[_a-zA-Z][_a-zA-Z0-9]*
        # @param superGroup [REF, nil]
        # @param fields [Array<Field>]
        def initialize(name, superGroup, fields)
            @schema = nil
            @name = name
            @fields = fields
            @superGroup = superGroup
        end
        
        # @macro common_to_s
        def to_s
            out = @name.to_s
            if @superGroup
                out << @superGroup.to_s
            end
            if @fields.size > 0            
                out << " ->\n"
                @fields.inject(out) do |acc, f|
                    acc << "    #{f}"
                    if @fields.last == f
                        acc << "\n"
                    else
                        acc << ",\n"
                    end
                end
            end
            out
        end
        
        # @macro common_link
        def link(schema,stack=[])
            if @schema != schema
                @list = {}        
                @schema = nil
                if !@superGroup or (@superGroup and @superGroup.link(schema, stack << self))                    
                    @fields.each do |s|
                        if @superGroup and @superGroup.value.field(s.name.to_s)
                            puts "duplicate field name in supergroup"
                            return nil
                        elsif @list[s.name.to_s]
                            puts "duplicate field name"
                            return nil
                        else
                            if s.link(schema, stack.dup << self)
                                @list[s.name.to_s] = s
                            else
                                return nil
                            end
                        end
                    end
                    @schema = schema
                end
            end
            @schema            
        end
        
        # @param name [String]
        # @return [Field]
        # @return [nil]
        # @raise [Error]
        def field(name)
            if !@schema
                raise Error.new "object must be linked"
            end
            result = @superGroup.field(name)
            if !result
                result = @list[name]
            end
            result
        end
    end
end
