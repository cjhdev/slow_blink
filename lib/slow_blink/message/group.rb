# @license
#   
#   Copyright (c) 2016 Cameron Harper
#     
#   Permission is hereby granted, free of charge, to any person obtaining a copy of
#   this software and associated documentation files (the "Software"), to deal in
#   the Software without restriction, including without limitation the rights to
#   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
#   the Software, and to permit persons to whom the Software is furnished to do so,
#   subject to the following conditions:
#   
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
# 
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
#   FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
#   COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module SlowBlink::Message

    # @abstract
    #
    # A Group may form a complete message or be nested as a {DynamicGroup}
    class Group

        # @private
        # @return [Hash<Field>] group fields
        def self.fields
            @fields
        end

        # @api user
        # @return [Integer,nil] group identifier
        def self.id
            @id
        end

        # @api user
        # @return [String] name of group
        def self.name
            @name
        end

        # @private
        # @param input [StringIO] Blink compact form
        # @param stack [Array] used to measure depth of recursion 
        # @return [Group, nil]
        # @raise [Error] recursion depth limit
        def self.from_compact(input, stack)            

            fields = {}
            extensions = []

            if stack.size < @maxRecursion
                stack << self
            else
                raise RecursionLimit
            end
            
            @fields.each do |fn, fd|
                fields[fn] = fd.from_compact(input, stack)
            end

            if !input.eof?
                expected = input.getU32
                if expected       
                    while extensions.size != expected do
                        extensions << @extensionObject.from_compact(input, stack)                    
                    end
                else
                    raise ExtensionPadding
                end
            end
            
            if !input.eof?
                raise ExtensionPadding
            end

            group = self.new(fields)

            extensions.each do |e|
                group.extension << group
            end

            stack.pop

            group
               
        end

        # @api user
        # @return [Array<Group>] extension objects
        attr_reader :extension

        # @api user
        # Finds Field by name and calls {Field#set}(value) 
        #
        # @param name [String] name of field
        # @param value [Object]
        # @raise [IndexError, TypeError]
        def []=(name, value)
            if @value[name]
                @value[name].set(value)
            else
                raise IndexError.new "field #{name} is not defined in this group"            
            end
            self
        end

        # @api user
        # Finds Field by name and calls {Field#get}
        #
        # @param name [String] name of field
        # @return [Object]
        # @raise [IndexError, TypeError]
        def [](name)            
            if @value[name]
                @value[name].get                
            else
                raise IndexError.new "field #{name} is not defined in this group"
            end            
        end

        # Get this group
        # @return [self]
        def get
            self
        end

        # Set the contents of this group
        #
        # @overload set(value)
        #   @param value [Hash{String=>Field,Numeric,String,Time,nil}] Hash of {Field} objects or literal values
        # @overload set(value)
        #   @param value [Group] a Hash of {Field} objects will be extracted from a Group object by calling {Group#fields}
        # @return [self]
        # @raise [IndexError, TypeError]
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
                        raise IndexError.new "field '#{fn}' is unknown"
                    end
                end
            # replace @value with value from another instance of self.class
            elsif value.is_a? self.class
                @value = value.fields.to_h
            else
                raise TypeError.new "expecting a Hash or a StaticGroup instance"
            end
            self
        end

        # @api user
        # Create a Group
        #
        # @note calls {#set}(fields)
        # @param fields [Hash]
        def initialize(fields={})
            @extension = []            
            @fields = self.class.fields
            @value = {}
            self.class.fields.each do |fn, fd|
                @value[fn] = fd.new(nil)
            end            
            set(fields)        
        end

        # @return [String] Blink Protocol compact form
        def encode_compact            
            if self.class.id
                to_compact("")
            else
                raise UntaggedGroup.new "cannot encode a group without an ID"
            end
        end

        # @private
        def to_compact(out)
            group = String.new.putU64(self.class.id)
            @value.each do |fn, fv|
                fv.to_compact(group)
            end
            if @extension.size > 0
                group.putU32(@extension.size)
                @extension.each do |e|
                    #if e.is_a? @extensionObject
                        e.to_compact(group)
                    #else
                     #   raise EncodingError.new "cannot convert unknown extension object to compact form"
                    #end
                end
            end
            out.putU32(group.size)
            out << group            
        end

        protected

            # Get the value hash directly
            # @return [Hash{String => Field}]
            def fields
                @value
            end

    end

    # @abstract
    #
    # A StaticGroup is a kind of {Group} that can only exist as the contents of a {Field}
    class StaticGroup < Group

        # @private
        #
        # @note optionality affects how instances of this type are encoded
        #
        # @return [true,false] is optional
        def self.opt?
            @opt
        end

        # @private
        # @param input [String] Blink compact form
        # @param stack [Array] used to measure depth of recursion 
        # @return [Group, nil]
        # @raise [Error] recursion depth limit
        def self.from_compact(input, stack)

            if stack.size < @maxRecursion
                stack << self
            else
                raise RecursionLimit
            end
        
            if @opt
                present = input.getPresent
            else
                present = true
            end
            if present
                fields = {}
                @fields.each do |fn, fd|
                    fields[fn] = fd.from_compact(input, stack)
                end
                result = self.new(fields)            
            else
                nil
            end

            stack.pop
            result
            
        end

        # @note StaticGroup does not have extensions
        # @raise [NoMethodError]
        def extension
            raise NoMethodError.new "StaticGroup does not implement #{__method__}"
        end
        
        # @private
        def to_compact(out)
            if self.class.opt?
                out.putPresent
            end
            @value.each do |fn, fv|
                fv.to_compact(out)
            end
            out            
        end

        # @note StaticGroup cannot be encoded as a top level message
        # @raise [NoMethodError]
        def encode_compact
            raise NoMethodError.new "StaticGroup does not implement #{__method__}"
        end

    end

    # @abstract
    #
    # A DynamicGroup has a {Group} which has a {Group.id} that appears in {DynamicGroup.permitted} list
    class DynamicGroup

        # @return [Hash] Hash of all groups referenced by name
        def self.groups
            @groups
        end

        # @return [Hash] Hash of all tagged groups referenced by ID
        def self.taggedGroups
            @taggedGroups
        end

        # @return [Array<Integer>] Array of group IDs that can be encapsulated by this DynamicGroup
        def self.permitted
            @permitted
        end

        # @private
        # @param input [StringIO] Blink compact form
        # @param stack [Array] used to measure depth of recursion 
        # @return [Group, nil]
        # @raise [Error] recursion depth limit
        def self.from_compact(input, stack)

            if stack.size < @maxRecursion
                stack << self
            else
                raise RecursionLimit
            end
        
            buf = input.getBinary
            
            if buf.size > 0
                buf = StringIO.new(buf)
                id = buf.getU64
                group = @taggedGroups[id]
                if group
                    if @permitted.include? group.id
                        result = self.new(group.from_compact(buf, stack))
                    else
                        raise WeakError15.new "W15: Group is known but unexpected"
                    end
                else
                    raise WeakError2.new "W2: Group id #{group.id} is unknown"
                end
            else
                raise WeakError5.new "W5: Value cannot be null"                
            end

            stack.pop
            result

        end

        def set(value)        
            # is group one of the groups we understand?
            if self.class.taggedGroups.values.detect{|g| value.is_a? g} 
                # is this group permitted?
                if self.class.permitted.include? value.class.id
                    @value = value
                else                        
                    raise TypeError.new "group is known but compatible with schema"
                end
            # native values
            elsif value.kind_of? Hash
                @value.set(value)
            else
                raise
            end
        end

        # @return [Group] contained group
        def get
            @value.get
        end

        # Calls {Group#extension}
        # @return [Array]
        def extension
            @value.extension
        end

        # @note calls {#set}(value)
        def initialize(value)
            set(value)        
        end

        # @private
        def to_compact(out)
            @value.to_compact(out)                                    
        end

    end

end
