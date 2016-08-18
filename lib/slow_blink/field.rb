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

    class Field

        include Annotatable

        # @return [NameWithID]
        attr_reader :nameWithID

        # @return [Type]
        attr_reader :type

        # @return [true] field is optional
        # @return [false] field is mandatory
        def opt?
            @opt
        end

        # @param nameWithID [NameWithID]
        # @param type   [Type]
        # @param opt    [true,false] field is optional?
        def initialize(nameWithID, type, opt)
            @schema = nil
            @nameWithID = nameWithID
            @type = type
            @opt = opt
        end

        # @!macro common_to_s
        def to_s
            "#{@type} #{@nameWithID}" + ((@opt) ? "?" : "")
        end

        # @!macro common_link
        def link(schema,stack=[])
            if @schema != schema
                @schema = nil
                if @type.link(schema, stack << self)
                    @schema = schema
                end
            end
            @schema
        end
    end
end
