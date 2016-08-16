module SlowBlink

    # schema
    class SchemaRef
    end

    # qName
    #
    
    class DefinitionRef < SchemaRef
        # @param qName [String,CName] name of the definition to annotate
        def initialize(qName)
            @qName = qName
        end
    end

    # qName.type
    class DefinitionTypeRef < DefinitionRef
    end

    # qName.name
    class FieldRef < SchemaRef
        def initialize(qName, name)
            @qName = qName
            @name = name
        end
    end

    # qName.name.type
    class Ref < FieldTypeRef
    end

end
