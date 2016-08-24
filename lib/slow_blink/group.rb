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

    class Group

        include Annotatable

        # @return [String]
        attr_reader :location

        # @return [NameWithID]
        attr_reader :nameWithID

        # @return [Array<Field>]
        def fields
            @fields.values
        end

        # @private
        #
        # @param nameWithID [NameWithID]
        # @param superGroup [REF, nil]
        # @param fields [Array<Field>]
        # @param location [String]
        def initialize(nameWithID, superGroup, fields, location)
            @annotes = {}
            @schema = nil
            @superGroup = superGroup
            @rawFields = fields
            @location = location
            @fields = []
            @nameWithID = nameWithID
        end
        
        # @private
        #
        # @macro common_link
        def link(schema,stack=[])
            if @schema.nil?
                errors = 0
                @fields = {}
                if !@superGroup or (@superGroup and @superGroup.link(schema, stack << self))                    
                    if !@superGroup or @superGroup.object.is_a?(Group)
                        if @superGroup
                            @superGroup.object.fields.each do |f|
                                 @fields[f.nameWithID.name] = f
                            end
                        end
                        @rawFields.each do |f|
                            if @fields[f.nameWithID.name]
                                puts "#{f.location} error: field with duplicate name '#{f.nameWithID.name}'"
                                errors += 1
                            else
                                if f.link(schema, stack.dup << self)
                                    @fields[f.nameWithID.name] = f
                                else
                                    errors += 1
                                end
                            end
                        end
                        if errors == 0
                            @schema = schema
                        end
                    else
                        puts "#{@superGroup.location} error: superGroup must be a group"
                    end
                end
            end
            @schema            
        end

        # @param name [String] name of field
        # @return [Field] field exists
        # @return [nil] field does not exist
        def field(name)
            @fields[name]
        end

        def group_kind_of?(superGroup)
            (self == superGroup) or (@superGroup and @superGroup.group_kind_of?(superGroup))            
        end

        # @private
        #
        # @param value [Hash] Blink JSON format
        # @param opts [Hash] options
        # @option opts [Symbol] :dynamic encode as dynamic group
        # @return [String] compact format
        def to_compact(value, **opts)            
            if value
                if opts[:dynamic]
                    out = CompactEncoder::putU64(@nameWithID.id)
                else
                    out = ""
                end
                @fields.each do |name, f|
                    out << f.to_compact(value)
                end
                if opts[:dynamic]
                    CompactEncoder::putU32(out.size) + out
                else
                    out
                end
            elsif opts[:optional] and value.nil?
                CompactEncoder::putU64(nil)
            else
                raise Error.new "expecting a group"
            end
        end

        def from_compact!(input, **opts)
            out["$type"] = @nameWithID.name
            @fields.each do |name, f|
                out[name] = f.from_compact!(value)
            end
            out
        end
        
    end
end
