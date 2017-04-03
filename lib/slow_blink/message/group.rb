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

    class Group

        attr_reader :extension

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

        def self.ancestorID
            @ancestorID
        end

        # @private
        def self.from_compact(input, depth)            

            value = {}

            if depth > 0
                depth = depth - 1
            else
                raise RecursionLimit
            end

            @fields.each do |f|
                value[f.name] = f.from_compact(input, depth)
            end

            depth = depth + 1

            self.new(value)
               
        end
        
        def initialize(fields={}, *extension)
            @value = {}
            self.class.fields.each{|f|@value[f.name] = f.new}
            set(fields)
            @extension = extension
        end

        # @api user
        # Finds Field by name and calls {Field#set}(value) 
        #
        # @param name [String] name of field
        # @param value [Object]
        # @raise [IndexError, TypeError]
        def []=(name, value)
            if field = @value[name]
                @value[name] = field.set(value)
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

        def set(value)
            if value.kind_of? Hash
                value.each do |fn, fv|
                    if @value[fn]
                        @value[fn] = @value[fn].set(fv)
                    else
                        raise IndexError.new "field '#{fn}' is unknown"
                    end
                end    
            else
                raise TypeError.new "expecting a Hash instance"
            end
            self
        end

        def get
            self
        end

        # @private
        def to_compact(out)
            @value.values.each{|f|f.to_compact(out)}            
        end

        def encode_compact(out="")       
            if self.class.id
                groupOut = String.new.putU64(self.class.id)
                to_compact(groupOut)
                if @extension.size > 0
                    groupOut.putU32(@extension.size)
                    @extension.each{|e|e.encode_compact(groupOut)}                    
                end
                
                out.putU32(groupOut.size)                
                out << groupOut                
            else
                raise UntaggedGroup.new "cannot encode a group without an ID"
            end
        end
        
    end

    class StaticGroup

        def self.group
            @groups[@type.name]
        end
        
        def self.from_compact(input, depth)
            self.new(group.from_compact(input, depth))            
        end

        def initialize(value)
            set(value)
        end
        
        def set(value)
            if value.is_a? self.class.group
                @value = value
            elsif value.is_a? Hash
                @value = self.class.group.new(value)
            else
                raise
            end
        end

        def get
            @value
        end
        
        # @private
        def to_compact(out)
            @value.to_compact(out)
        end

    end

    class DynamicGroup

        def self.taggedGroups
            @taggedGroups
        end

        def self.permittedID
            @permittedID
        end

        def self.from_compact(input, depth)

            group = nil

            if depth > 0
                depth = depth - 1
            else
                raise RecursionLimit
            end

            if input.kind_of? String
                input = StringIO.new(input)
            end

            buf = input.getBinary

            if buf.nil?

                group = nil

            elsif buf.size == 0

                raise WeakError5.new "W5: Value cannot be null"                
        
            else

                buf = StringIO.new(buf)
                id = buf.getU64

                if klass = @taggedGroups[id]

                    if @permittedID.include? id

                        group = klass.from_compact(buf, depth)

                        if !buf.eof?                
                            size = buf.getU32
                            while group.extension.size < size do
                                group.extension << @anyTaggedGroup.from_compact(buf, depth).get
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
                
            end

            depth = depth + 1
            self.new(group)

        end

        def set(value)
            if value.kind_of? Group
                if self.class.permittedID.include? value.class.id        
                    @value = value
                else                        
                    raise TypeError.new "incompatible group"
                end
            else
                raise ArgumentError.new "argument must be kind_of Group"
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
            @value.encode_compact(out)        
        end

        def extension
            @value.extension
        end

    end

end
