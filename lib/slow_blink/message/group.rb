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

        def encode_compact(out="".force_encoding("ASCII-8BIT"))       
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

        def to_tag_value
            @value.values.inject(""){|out,f|out << f.to_tag}            
        end

        def to_tag_extension
            if @extension.size > 0
                out = "|["
                @extension.each do |e|
                    if e != @extension.first
                        out << ";"
                    end
                    out << e.to_tag
                end
                out << "]"
            else
                out = ""
            end            
        end

        def to_tag
            "@#{self.class.name}#{to_tag_value}#{to_tag_extension}"
        end

    end

end
