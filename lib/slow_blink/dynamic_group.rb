module SlowBlink
    class DynamicGroup < StaticGroup
        def groups
            @table.values.select{|d|d.is_a? Group and d.id and (d.ancestors.include? @group or d == @group)}
        end
        def kind_of? group
            ancestors = [@group]
            ptr = @group.superGroup
            while ptr do
                ancestors.unshift ptr
                ptr = ptr.superGroup
            end
            ancestors.include? group
        end
    end
end
