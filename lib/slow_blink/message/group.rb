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

module SlowBlink::Message

    class Group

        # @param [Hash<Field>] group fields
        def self.fields
            @fields
        end

        # @return [Integer,nil] group identifier
        def self.id
            @id
        end

        # @return [String] name of group
        def self.name
            @name
        end

        # @param input [String] Blink compact form
        # @return [StaticGroup] instance of anonymous subclass of StaticGroup
        def self.from_compact!(input)            
            fields = {}
            @fields.each do |fn, fd|
                fields[fn] = fd.from_compact!(input)
            end
=begin            
            if input.size > 0
                expected = buf.getU32!
                while extensions.size != expected do
                    extensions << self.from_compact!(buf)
                end
            end
            if input.size != 0
                raise Error.new "extra bytes at end of group after extensions"
            end
=end            
            self.new(fields)   
        end

        def each(&block)
            @value.values.each(&block)            
        end

        def []=(name, value)
            if @value[name]
                @value[name].set(value)
            else
                raise "field #{name} is not defined in this group"            
            end
        end

        def name
            self.class.name
        end

        def id
            self.class.id
        end

        # Call get on field 'name'
        # @see Field#get
        # @param name [String] name of field
        # @return [Object]        
        def [](name)            
            if @value[name]
                @value[name].get                
            else
                raise "field #{name} is not defined in this group"
            end            
        end

        def get
            self
        end

        def fields
            @value
        end

        def set(value)
            if value.kind_of? Hash
                value.each do |fn, fv|
                    if @value[fn]
                        # replace entire field
                        if fv.is_a? @value[fn].class
                            @value[fn] = fv
                        # set value of field
                        else
                            @value[fn].set(fv)
                        end
                    else
                        raise Error.new "field '#{fn}' is unknown"
                    end
                end
            # replace @value with value from another instance of self.class
            elsif value.is_a? self.class
                @value = value.fields.to_h
            else
                raise Error.new "expecting a Hash or a StaticGroup instance"
            end
        end

        def extension
            @extension
        end
        
        # Create a Group
        #
        # @param fields [Hash] associative array of slow blink objects or native values
        def initialize(fields={})
            @extension = []            
            @fields = self.class.fields
            @value = {}
            self.class.fields.each do |fn, fd|
                @value[fn] = fd.new(nil)
            end            
            set(fields)        
        end
        
        def encode_compact
            if self.class.id
                to_compact("")            
            else
                raise "cannot encode a group without an ID"
            end
        end

        def to_compact(out)
            group = "".putU64(self.class.id)
            @value.each do |fn, fv|
                fv.to_compact(group)
            end
            if @extension.size > 0
                group.putU32(@extension.size)
                @extension.each do |e|
                    e.to_compact(group)
                end
            end
            out.putU32(group.size)
            out << group        
        end

    end

    # static subgroup
    class StaticGroup < Group

        # @param [true,false] element is referenced by an optional field
        def self.opt?
            @opt
        end
    
        # @param input [String] Blink compact form
        # @return [StaticGroup] instance of anonymous subclass of {StaticGroup}
        def self.from_compact!(input)
            if @opt
                present = input.getPresent
            else
                present = true
            end
            if present
                fields = {}
                @fields.each do |fn, fd|
                    fields[fn] = fd.from_compact!(input)
                end
                self.new(fields)            
            else
                nil
            end        
        end

        def extension
            raise "static groups cannot have extensions"
        end

        def to_compact(out)
            if @opt
                out.putPresent
            end
            @value.each do |fn, fv|
                fv.to_compact(out)
            end
            out            
        end

    end

    # A DynamicGroup subgroup has a Group which may be restricted by Group::id according to DynamicGroup::permitted
    class DynamicGroup

        def self.groups
            @groups
        end

        # @return [Array<Integer>] Array of group IDs that can be encapsulated by this DynamicGroup
        def self.permitted
            @permitted
        end
        
        def self.from_compact!(input)
            buf = input.getBinary!
            if buf.size > 0
                id = buf.getU64!
                group = @groups[id]
                if group
                    if @permitted.include? group.id
                        self.new(group.from_compact!(buf))
                    else
                        raise Error.new "W15: Group is known but unexpected"
                    end
                else
                    raise Error.new "W2: Group id #{group.id} is unknown"
                end
            else
                raise Error.new "W5: Value cannot be null"                
            end
        end

        def name
            @value.name
        end

        def id
            @value.id
        end

        def set(value)        
            # is group one of the groups we understand?
            if self.class.groups.values.detect{|g| value.is_a? g} 
                # is this group permitted?
                if self.class.permitted.include? value.class.id
                    @value = value
                else                        
                    raise "group valid but not expected"
                end
            # native values
            elsif value.kind_of? Hash
                @value.set(value)
            else
                raise
            end
        end

        def get
            @value.get
        end

        def extension
            @value.extension
        end

        def initialize(value)
            set(value)        
        end

        def to_compact(out)
            @value.to_compact(out)                                    
        end

    end

end
