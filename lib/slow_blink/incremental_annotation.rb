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

    # Blink Specification 7.3
    class IncrementalAnnotation

        attr_reader :ref
        attr_reader :annotes
        attr_reader :location

        # @private
        #
        # @param ref [SchemaRef, DefinitionRef, DefinitionTypeRef, FieldRef, FieldTypeRef] annotation target
        # @param annotations [Array<Integer,Annotation>]
        # @param location [String]    
        def initialize(ref, annotes, location)
            @ref = ref
            @annotes = annotes
            @location = location
            @schema = nil
        end

        # @private
        #
        # Apply annotes to targets
        #
        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                @schema = nil
                case @ref.class
                when SchemaRef
                    schema.annote(@annotes)
                    @schema = schema
                when DefinitionRef
                    object = schema.symbol(@ref.qName)
                    if object
                        object.annote(@annotes)
                        @schema = schema
                    end
                when DefinitionTypeRef
                    object = schema.symbol(@ref.qName)
                    if object
                        object.enumOrType.annote(@annotes)
                        @schema = schema
                    end
                when FieldRef
                    object = schema.symbol(@ref.qName)
                    if object
                        field = object.field(@ref.name)
                        if field
                            field.annote(@annotes)
                            @schema = schema
                        end                    
                    end                
                when FieldTypeRef
                    object = schema.symbol(@ref.qName)
                    if object
                        field = object.field(@ref.name)
                        if field
                            field.type.annote(@annotes)
                            @schema = schema
                        end                    
                    end                
                else
                    raise "unknown component reference #{@ref.class}".freeze
                end                    
            end
            @schema                
        end        
        
    end
end
