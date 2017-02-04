module SlowBlink
    class StaticGroup < Type

        # @return [String]
        def name
            @group.name
        end
        
        # @return [Integer,nil]
        def id
            @group.id
        end

        # @return [Array<Field>]
        def fields
            @group.fields
        end

        # @return [Group]
        def superGroup
            @group.superGroup
        end

        # @return [Array<Groups>]
        def ancestors
            @group.ancestors            
        end

        # @private
        def initialize(attr)
            super(attr)
            @group = attr[:group]
            @table = attr[:table]
        end
         
    end
end
