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

        attr_reader :componentReference
        attr_reader :annotes
        attr_reader :location

        # @private
        #
        # @param componentReference [SchemaRef, DefinitionRef, DefinitionTypeRef, FieldRef, FieldTypeRef] annotation target
        # @param annotations [Array<Integer,Annotation>]
        # @param location [String]    
        def initialize(componentReference, annotes, location)
            @componentReference = componentReference
            @annotes = annotes
            @location = location
            @schema = nil
        end

        # @private
        #
        # Apply annotes to targets
        #
        # @param schema [Schema]
        # @param namespace [Namespace] the namespace this annotation was defined in
        #
        def apply(schema, namespace)
            if @schema.nil?
                case @componentReference.class
                when SchemaRef # this actually refers to the Namespace
                    namespace.annote(@annotes)
                    @schema = schema
                when DefinitionRef
                    object = schema.resolve(@componentReference.namespace, @componentReference.name)
                    if object
                        object.annote(@annotes)
                        @schema = schema
                    end
                when DefinitionTypeRef
                    object = schema.resolve(@componentReference.namespace, @componentReference.name)
                    if object
                        object.enumOrType.annote(@annotes)
                        @schema = schema
                    end
                when FieldRef
                    object = schema.resolve(@componentReference.namespace, @componentReference.name)
                    if object
                        field = object.field(@componentReference.subname)
                        if field
                            field.annote(@annotes)
                            @schema = schema
                        end                    
                    end                
                when FieldTypeRef
                    object = schema.resolve(@componentReference.namespace, @componentReference.name)
                    if object
                        field = object.field(@componentReference.subname)
                        if field
                            field.type.annote(@annotes)
                            @schema = schema
                        end                    
                    end                
                else
                    raise "unknown component reference #{@componentReference.class}".freeze
                end                    
            end
            @schema                
        end        
        
    end

    # SCHEMA
    class SchemaRef
        def self.===(other)
            self == other
        end
    end

    # qName
    class DefinitionRef < SchemaRef
        attr_reader :namespace
        attr_reader :name
        attr_reader :qname
        # @param qName [String] name of the definition to annotate
        def initialize(qname)
            @qname = qname
            if qname.split(":").size == 1
                @namespace = nil
                @name = qname                
            else                
                @namespace = qname.split(":").first
                @name = qName.split(":").last
            end
        end
    end

    # qName.TYPE
    class DefinitionTypeRef < DefinitionRef
    end

    # qName.name
    class FieldRef < SchemaRef
        attr_reader :namespace
        attr_reader :name
        attr_reader :qname
        attr_reader :subname
        def initialize(qname, name)
            @qname = qname
            if qname.split(":").size == 1
                @namespace = nil
                @name = qname                
            else                
                @namespace = qname.split(":").first
                @name = qName.split(":").last
            end
            @subname = name
        end
    end

    # qName.name.TYPE
    class FieldTypeRef < FieldRef
    end
    
end
