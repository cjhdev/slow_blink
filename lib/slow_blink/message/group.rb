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

    class StaticGroup

        # @private
        # @return [Array<Field>] group fields
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
        # @param input [StringIO, String] Blink compact form
        # @param stack [Array] used to measure depth of recursion 
        # @return [Group, nil]
        # @raise [Error] recursion depth limit
        def self.from_compact(input, stack)            

            fields = {}

            if stack.size < @maxRecursion
                stack << self
            else
                raise RecursionLimit
            end

            @fields.each do |f|
                fields[f.name] = f.from_compact(input, stack)
            end

            stack.pop
            
            self.new(fields)
               
        end

        # @api user
        # Finds Field by name and calls {Field#set}(value) 
        #
        # @param name [String] name of field
        # @param value [Object]
        # @raise [IndexError, TypeError]
        def []=(name, value)
            if field = @value[name]
                field.set(value)
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
            if field = @value[name]
                field.get                
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
            elsif value.kind_of? self.class
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
            @value = {}
            self.class.fields.each do |f|
                @value[f.name] = f.new(nil)
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
            @value.each do |fn, fv|
                fv.to_compact(out)
            end        
        end

        protected

            # Get the value hash directly
            # @return [Hash{String => Field}]
            def fields
                @value
            end

    end
    
    class Group < StaticGroup

        attr_reader :extension

        def self.ancestorID
            @ancestorID
        end

        def initialize(fields={}, *extension)
            super(fields)
            @extension = extension
        end

        # @private
        def to_compact(out)

            groupOut = String.new.putU64(self.class.id)
            super(groupOut)
            if @extension.size > 0
                groupOut.putU32(@extension.size)
                @extension.each do |e|
                    e.to_compact(groupOut)                    
                end
            end

            out.putU32(groupOut.size)
            out << groupOut
    
        end
        
    end

    class DynamicGroup

        def self.taggedGroups
            @taggedGroups
        end

        def self.permittedID
            @permittedID
        end

        # @private
        # @param input [StringIO] Blink compact form
        # @param stack [Array] used to measure depth of recursion 
        # @return [Group, nil]
        # @raise [Error] recursion depth limit
        def self.from_compact(input, stack)

            group = nil

            if stack.size < @maxRecursion
                stack << self
            else
                raise RecursionLimit
            end
        
            if input.kind_of? String
                input = StringIO.new(input)
            end

            buf = input.getBinary
            
            if buf.size > 0

                buf = StringIO.new(buf)
                id = buf.getU64

                if klass = @taggedGroups[id]

                    if @permittedID.include? id

                        group = klass.from_compact(buf, stack)

                        if !buf.eof?                
                            size = buf.getU32
                            while group.extension.size < size do
                                group.extension << @anyTaggedGroup.from_compact(buf, stack)
                            end
                        end

                        if !buf.eof?
                            raise ExtensionPadding
                        end
                        
                    else
                        raise WeakError15.new "W15: Group is known but unexpected"
                    end
                else
                    raise WeakError2.new "W2: Group id #{id} is unknown"
                end
                
            elsif stack.size == 1
                raise WeakError5.new "W??: top level cannot be null"
            else                
                raise WeakError5.new "W5: Value cannot be null"                
            end

            stack.pop
            group

        end

        def set(value)
            if value.kind_of? Group
                if self.class.permittedID.include? value.class.id        
                    @value = value
                else                        
                    raise TypeError.new "incompatible group"
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

        # @note calls {#set}(value)
        def initialize(value)
            set(value)
        end

        # @private
        def to_compact(out)
            @value.to_compact(out)    
        end

        def extension
            @value.extension
        end

    end

end
