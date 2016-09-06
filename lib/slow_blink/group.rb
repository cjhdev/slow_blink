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

        def self.===(other)
            self == other                
        end

        # @return [String]
        attr_reader :location

        # @return [NameWithID]
        attr_reader :nameWithID

        # @return [Array<Field>]
        def fields
            @fields.values
        end

        # @param namespace [Namespace]
        def namespace=(namespace)
            @ns = namespace
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
            @ns = nil
        end
        
        # @private
        #
        # @macro common_link
        def link(schema,stack=[])
            
            if @schema.nil?

                # a definition can resolve to a definition only if there is a dynamic
                # link somewhere in the chain
                sf = stack.each
                begin
                    loop do
                        if sf.next == self
                            loop do
                                begin
                                    f = sf.next
                                    if f.respond_to? "dynamic?".to_sym and f.dynamic?
                                        return schema
                                    end
                                rescue StopIteration
                                    raise Error.new "#{self.location}: error: invalid cycle detected"
                                end
                            end
                        end
                    end
                rescue StopIteration
                end

                error = false
                @fields = {}
                if !@superGroup or (@superGroup and @superGroup.link(schema, @ns, stack << self))                    
                    if !@superGroup or @superGroup.ref.is_a?(Group)
                        if @superGroup
                            if @superGroup.dynamic_reference?
                                Log.error "#{@superGroup.location}: error: reference to supergroup must not be dynamic"
                                error = true                                
                            else
                                @superGroup.ref.fields.each do |f|
                                    @fields[f.nameWithID.name] = f
                                end
                            end
                        end
                        if !error
                            @rawFields.each do |f|
                                if @fields[f.nameWithID.name]
                                    Log.error "#{f.location}: error: field names must be unique within a group ('#{f.nameWithID.name}' first appears at #{@fields[f.nameWithID.name].location})"
                                    error = true
                                else
                                    if f.link(schema, @ns, stack.dup << self)                                    
                                        @fields[f.nameWithID.name] = f
                                    else
                                        error = true
                                    end
                                end
                            end
                        end
                    else
                        Log.error "#{@superGroup.location}: error: reference to supergroup must resolve to group definition"
                        error = true
                    end
                else
                    error = true
                end

                if !error
                    @schema = schema
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

        # Is this group a sub group of the super group?
        #
        # @param superGroup [Group]
        # @return [true,false]
        def group_kind_of?(superGroup)
            (self == superGroup) or (@superGroup and @superGroup.ref.group_kind_of?(superGroup))            
        end

    end
end
