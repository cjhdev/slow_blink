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

    def self.putError(location, message)
        "#{location} error: #{message}"
    end

    class Group

        include Annotatable

        attr_reader :location
        
        # @return [String]
        attr_reader :name

        # @return [Integer]
        attr_reader :id

        def self.setValue(value)
            @id = value
        end

        # @param nameWithID [NameWithID]
        # @param superGroup [REF, nil]
        # @param fields [Array<Field>]
        # @param location [String]
        def initialize(nameWithID, superGroup, fields, location)
            @annotes = {}
            @schema = nil
            @name = nameWithID.name
            @id = nameWithID.id
            @superGroup = superGroup
            @rawFields = fields
            @location = location
            @fields = {}
        end
        
        # @macro common_link
        def link(schema,stack=[])
            if @schema != schema
                errors = 0
                @schema = nil
                @fields = {}
                if !@superGroup or (@superGroup and @superGroup.link(schema, stack << self))                    
                    if !@superGroup or @superGroup.value.is_a?(Group)
                        @rawFields.each do |f|
                            if @superGroup and @superGroup.value.field(f.name)
                                puts "#{f.location}: error: field with duplicate name '#{f.name}'"
                                errors += 1
                            elsif @fields[f.name]
                                puts "#{f.location}: error: field with duplicate name '#{f.name}'"
                                errors += 1
                            else
                                if f.link(schema, stack.dup << self)
                                    @fields[f.name] = f
                                else
                                    errors += 1
                                end
                            end
                        end
                        if errors == 0
                            @schema = schema
                        end
                    else
                        puts "#{@superGroup.location}: error: superGroup '#{@superGroup.name}' must be a group"
                    end
                end
            end
            @schema            
        end
        
        # @param name [String]
        # @return [Field]
        # @return [nil]
        # @raise [Error]
        def field(name)
            if @schema
                result = nil
                if @superGroup
                    result = @superGroup.value.field(name)
                end
                if !result
                    result = @fields[name]
                end
                result
            else
                raise Error.new "object must be linked"
            end
        end
    end
end
