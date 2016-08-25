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

        # @return [String]
        attr_reader :location

        # @return [Type]
        attr_reader :type

        # @return [NameWithID]
        attr_reader :nameWithID

        attr_reader :name
        attr_reader :id

        # @return [true] field is optional
        # @return [false] field is mandatory
        def opt?
            @opt
        end

        # @private
        #
        # @param nameWithID [NameWithID]
        # @param type   [Type]
        # @param opt    [true,false] field is optional?
        # @param location [String]
        def initialize(nameWithID, type, opt, location)
            @annotes = {}
            @schema = nil
            @type = type
            @opt = opt
            @location = location
            @nameWithID = nameWithID
            @name = nil
            @id = nil
        end

        # @private
        #
        # @!macro common_link
        def link(schema,stack=[])
            if @schema.nil?
                if @type.link(schema, stack << self)
                    @schema = schema
                end
                @name = @nameWithID.name
                @id = @nameWithID.id
            end
            @schema
        end

        # @private
        def to_compact(value, **opts)
            if value[@nameWithID.name] or @opt
                begin
                    @type.to_compact(value[@nameWithID.name], optional: @opt)
                rescue Error => ex
                    raise Error.new "[#{@nameWithID.name}]: #{ex}"
                end
            else
                raise Error.new "expecting a field named #{@nameWithID.name}"
            end
        end

        def from_compact!(input, **opts)
            opts[:optional] = @opt
            @type.from_compact!(input, **opts)                
        end
        
    end
end
