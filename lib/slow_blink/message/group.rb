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

    # A StaticGroup has zero or more Fields
    class StaticGroup

        # @param [Hash<Field>] group fields
        def self.fields
            @fields
        end

        # @param [true,false] element is referenced by an optional field
        def self.opt?
            @opt
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
            if @opt
                if input.getPresent!
                    fields = {}
                    @fields.each do |fn, f|
                        fields[fn] = f.from_compact!(input)
                    end
                    self.new(fields)
                else
                    self.new(nil)
                end
            else
                fields = {}
                @fields.each do |fn, f|
                    fields[fn] = f.from_compact!(input)
                end
                self.new(fields)
            end            
        end

        # Create a group from a native structure of native values
        # @param native [Hash]
        # @return [StaticGroup]
        def self.from_native(native)
            if native
                if native.kind_of? Hash
                    fields = {}
                    native.each do |fn, f|
                        if @fields[fn]
                            fields[fn] = @fields[fn].from_native(f)
                        else
                            raise "unknown field '#{fn}'"
                        end
                    end
                    self.new(fields)                    
                else
                    raise "expecting a hash"
                end
            else
                self.new(nil)
            end
        end

        def each(&block)
            if @present
                @value.values.each(&block)
            end
        end

        # Call get on field 'name'
        # @see Field#get
        # @param name [String] name of field
        # @return [Object]        
        def [](name)
            if @present
                if @value[name]
                    @value[name].get                
                else
                    raise "field #{name} is not defined in this group"
                end
            else
                raise "group is not instanciated"
            end
        end

        # Get group fields
        # @return [Hash] name => value for each field
        def get
            if @present
                self
            else
                nil
            end
        end

        # Create a Group
        #
        # @param fields [Hash] associative array of slow blink objects
        # @param fields [nil] empty
        def initialize(fields)
            @present = false
            @value = {}
            if fields
                if fields.kind_of? Hash
                    fields.each do |fn, f|
                        if self.class.fields[fn] and f.is_a? self.class.fields[fn].type
                            @value[fn] = f
                            @present = true
                        else
                            raise "unexpected object: #{f.inspect}"
                        end
                    end
                else
                    raise "unexpected input"
                end
            end
            self.class.fields.each do |fn, f|
                if @value[fn].nil?
                    @value[fn] = f.new(nil)
                end
            end            
        end
        
        def fields
            @value
        end

        def to_compact(out)
            if @present                            
                if self.class.opt?
                    out.putPresent
                    @value.each do |fn, fv|
                        fv.to_compact(out)
                    end
                    out                    
                else
                    @value.each do |fn, fv|
                        fv.to_compact(out)
                    end
                    out                                        
                end                
            else
                out.putPresent(false)
            end
        end

    end

    # A DynamicGroup has a StaticGroup which may be restricted by StaticGroup::id according to DynamicGroup::permitted
    class DynamicGroup

        def self.top?
            @top
        end

        def self.groups
            @groups
        end

        # @return [Array<Integer>] Array of group IDs that can be encapsulated by this DynamicGroup
        def self.permitted
            @permitted
        end

        # @param [true,false] DynamicGroup is referenced by an optional field
        def self.opt?
            @opt
        end

        def self.from_compact!(input)
            buf = input.getBinary!
            if buf.size > 0
                id = buf.getU64!
                group = @groups[id]
                if group
                    if @permitted.include? group.id
                        group = group.from_compact!(buf)
                        extensions = []
                        while buf.size > 0
                            extensions << self.from_compact!(buf)
                        end
                        self.new(group, *extensions)
                    else
                        raise Error.new "W15: Group is known but unexpected"
                    end
                else
                    raise Error.new "W2: Group id #{group.id} is unknown"
                end
            else
                if self == ModelInstance
                    raise Error.new "W1: Top level group cannot be null"
                elsif @opt
                    self.new(nil)
                else
                    raise Error.new "W5: Value cannot be null"
                end                
            end
        end

        # A DynamicGroup can only be expressed "natively" as a DynamicGroup instance
        # 
        # @param native [DynamicGroup]
        def self.from_native(native)        
            if native
                self.new(native.group, *native.extension)
            elsif @opt
                self.new(nil)
            else
                raise "cannot be null"
            end
        end

        def [](name)
            if @value
                @value[name]
            else
                raise "undefined dynamic group"
            end
        end

        def get
            @value
        end

        def group
            @value
        end

        def extension
            @extension
        end

        def each(&block)
            if @value
                @value.each(&block)                            
            end
        end

        def initialize(group, *extension)
            if group
                # is group one of the groups we understand?
                if self.class.groups.values.detect{|g| group.is_a? g} 
                    # is this group permitted?
                    if self.class.permitted.include? group.class.id
                        # do we understand the extensions?
                        extension.each do |e|
                            if !self.class.groups.values.detect{|g| group.is_a? g}
                                raise "extension must be a DynamicGroup subclass instance"
                            end
                        end
                        @value = group
                        @extension = extension                    
                    else                        
                        raise "group valid but not expected"
                    end
                else
                    raise "expecting DynamicGroup subclass instance"
                end
            else
                @value = nil
                @extension = []
            end
        end               

        # Encode {Group} as Blink compact form
        #
        # @param out [String] string to append to
        # @return [String]
        def to_compact(out)
            if @value
                group = @value.to_compact("".putU64(@value.class.id))
                @extension.each do |e|
                    e.to_compact(group)
                end
                out.putU32(group.size)
                out << group                          
            else
                out.putU32(nil)
            end
        end

        # @api user
        #
        # Encode {Group} as Blink compact form
        #
        # @return [String]
        #
        def encode_compact
            to_compact("")
        end        

    end

end
