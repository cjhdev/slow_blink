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


module SlowBlink

    class Group

        def self.===(other)
            self == other                
        end

        # @return [Integer,nil]
        attr_reader :id

        # @return [String] qualified name
        attr_reader :name

        # @macro location
        attr_reader :location
        
        # @return [Array<Field>]
        def fields

            # collect all ancestors
            ancestors = []
            ptr = superGroup
            while ptr do
                ancestors.unshift ptr
                ptr = ptr.superGroup
            end

            result = {}

            ancestors.each do |g|
                g.rawFields.each do |f|
                    result[f.name] = f                    
                end
            end

            @fields.each do |fn, fv|
                if result[fn]
                    raise ParseError.new "#{fv.location}: field name shadowed by supergroup"
                else
                    result[fn] = fv
                end
            end

            result.values
        end

        # @return [Array<Group>] super groups in order of most super
        def ancestors
            result = []
            ptr = superGroup
            while ptr do
                result << ptr
                ptr = ptr.superGroup
            end
            result
        end

        # @return [Group,nil]
        def superGroup

            result = nil

            if @super

                ptr = @super.resolve
                stack = []
                sequence = false
                dynamic = false

                while ptr and ptr.is_a? Definition and ptr.type.is_a? REF do

                    if stack.include? ptr
                        raise ParseError.new "#{@super.location}: supergoup circular reference"
                    else
                        if ptr.type.dynamic?
                            dynamic = true
                        end
                        if ptr.type.sequence?
                            if sequence
                                raise ParseError.new "#{@super.location}: sequence of sequence detected at '#{ptr.type.location}'"
                            end
                            sequence = true                            
                        end
                        stack << ptr
                        ptr = ptr.type.resolve                        
                    end
                end

                if ptr.nil?
                    raise ParseError.new "#{@super.location}: supergroup reference '#{@super.ref}' does not resolve"
                elsif ptr.is_a? Definition
                    if dynamic
                        raise ParseError.new "#{@super.location}: supergroup reference cannot resolve dynamic reference to a #{ptr.type.class} makes no sense"
                    end
                    raise ParseError.new "#{@super.location}: supergroup reference must resolve to a group"
                else
                    if dynamic
                        raise ParseError.new "#{@super.location}: supergroup reference cannot be dynamic"
                    end
                    if sequence
                        raise ParseError.new "#{@super.location}: supergroup reference cannot be a sequence"
                    end
                    if ptr == self
                        raise ParseError.new "#{@super.location}: supergroup cannot be own group"
                    end
                    result = ptr
                end
            end

            result
        end

        # @private
        def initialize(attr)

            @ns = attr[:ns].freeze
            @name = attr[:name][:name].dup
            if @ns
                @name.prepend "#{@ns}::"
            end
            @name.freeze 
            @id = attr[:name][:id]
            @location = attr[:name][:loc].freeze
            @fields = {}

            if attr[:super]
                @super = REF.new(attr[:super].merge(:table=>attr[:table], :ns=>attr[:ns]))
                if @super.ref == @name or @super.ref.split("::").last == @name
                    raise ParseError.new "#{@location}: supergroup cannot be own group"
                end
            else
                @super = nil
            end

            attr[:fields].each do |f|
                if @fields[f[:name][:name]]
                    raise ParseError.new "#{f[:location]}: duplicate field name"
                else
                    @fields[f[:name][:name]] = Field.new(f.merge({:table => attr[:table], :ns => attr[:ns]}))
                end
            end

        end

        protected

            def rawFields
                @fields.values
            end

    end
end
