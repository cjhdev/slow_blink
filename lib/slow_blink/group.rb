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
        # @param name [String] [\\]?[_a-zA-Z][_a-zA-Z0-9]*
        # @param superGroup [String] this group inherits superGroup
        # @param fields [Array<Field>]
        def initialize(name, superGroup, fields)
            @schema = nil
            @name = name
            @fields = {}
            if superGroup
                @superGroup = superGroup.to_s
            end
            fields.each do |f|
                @fields[field.name] = field
                duplicateNames = fields.select{|other|f.name == other.name}
                duplicateIDs = fields.select{|other|f.id and (f.id == other.id)}
            end
            fcount = 0        
        end
        def to_s
            
        end
        # @macro common_link
        def link(schema,stack=[])
        end
    end
end
