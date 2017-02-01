# @license
#   
#   Copyright (c) 2016 Cameron Harper
#     
#   Permission is hereby granted, free of charge, to any person obtaining a copy of
#   this software and associated documentation files (the "Software"), to deal in
#   the Software without restriction, including without limitation the rights to
#   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
#   the Software, and to permit persons to whom the Software is furnished to do so,
#   subject to the following conditions:
#   
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
# 
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
#   FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
#   COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


module SlowBlink

    class Field

        attr_reader :id
        attr_reader :name
        attr_reader :location

        # @return [DynamicGroup, StaticGroup, Enum, Bool, U8, ]
        # 
        #
        #
        def type
            result = nil
            if @type.is_a? REF
        
                ptr = @type.resolve
                stack = []
                sequence = @type.sequence?
                dynamic = @type.dynamic?

                while ptr and ptr.is_a? Definition and ptr.type.is_a? REF do

                    if stack.include? ptr
                        raise ParseError.new "#{ptr.location}: circular reference detected"
                    else
                        if ptr.type.dynamic?
                            # assumption: double dynamic is still dynamic
                            dynamic = true
                        end
                        if ptr.type.sequence?
                            if sequence
                                raise ParseError.new "#{ptr.location}: sequence of sequences detected while resolving from '#{@type.location}'"
                            end
                            sequence = true                            
                        end
                        stack << ptr
                        ptr = ptr.type.resolve
                    end
                end

                if ptr.nil?
                    if stack.size == 0
                        stack << @type
                    end
                    raise ParseError.new "#{stack.last.location}: reference does not resolve"
                elsif ptr.is_a? Group
                    if dynamic
                        result = DynamicGroup.new(:group => ptr, :sequence => sequence, :table => @table)
                    else
                        result = StaticGroup.new(:group => ptr, :sequence => sequence, :table => @table)
                    end
                else
                    result = ptr.type
                end
            else
                result = @type
            end

            result
        end
    
        def optional?
            @optional
        end

        def initialize(attr)        
            @name = attr[:name][:name].freeze
            @id = attr[:name][:id]
            @optional = attr[:opt]
            @location = attr[:location].freeze
            @type = SlowBlink.const_get(attr[:type][:class]).new(attr[:type].merge({:table => attr[:table], :ns => attr[:ns]}))
            @table = attr[:table]
        end
        
    end
end
