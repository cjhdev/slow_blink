module SlowBlink
    class StaticGroup < Type
        def name
            @group.name
        end
        def id
            @group.id
        end
        def fields
            @group.fields
        end
        def superGroup
            @group.superGroup
        end
        def ancestors
            @group.ancestors            
        end
        def initialize(attr)
            super(attr)
            @group = attr[:group]
            @table = attr[:table]
        end        
    end
end
