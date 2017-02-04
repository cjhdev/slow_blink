module SlowBlink
    class DynamicGroup < StaticGroup
        # @return [Array<Group>] groups that are compatible with this dynamic group
        def groups
            @table.values.select{|d|d.is_a? Group and d.id and (d.ancestors.include? @group or d == @group)}
        end        
    end
end
