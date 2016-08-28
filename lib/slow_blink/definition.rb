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
    class Definition

        include Annotatable

        # @return [String]
        attr_reader :location

        # @return [String]
        attr_reader :nameWithID

        # @return [ENUMERATION]
        # @return [Type]
        attr_reader :enumOrType

        # @param namespace [Namespace]
        def namespace=(namespace)
            @ns = namespace
        end

        # @private
        #
        # @param nameWithID [NameWithID]
        # @param enumOrType [ENUMERATION, Type]
        # @param location [String]
        def initialize(nameWithID, enumOrType, location)
            @annotes = {}
            @schema = nil
            @enumOrType = enumOrType
            @location = location
            @nameWithID = nameWithID
            @ns = nil
        end

        # @private
        #
        # @!macro common_link
        def link(schema, stack=[])
            if @schema.nil?
                @schema = @enumOrType.link(schema, @ns, stack << self)
            end
            @schema
        end

    end
end
