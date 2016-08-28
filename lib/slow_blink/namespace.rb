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

    class Namespace

        include Annotatable

        # @return [Hash<Definition>]
        attr_reader :definitions

        # @return [Array<Group>]
        attr_reader :groups

        # @return [String]
        attr_reader :name

        # @return [Array<IncrementalAnnotation>]
        attr_reader :incrAnnotations

        # @!method self.parse(input, **opts)
        #
        #   @param input [String] Blink Schema
        #   @param opts [Hash] options
        #   @option opts [String] :fileName filename to append to error message strings
        #   @return [Namespace]

        # @private
        #
        # @param filename [nil,String]
        # @param name [nil,String]
        # @param defs [Array<Definition,Group>]
        def initialize(filename, name, defs)

            @filename = filename
            @annotes = {}
            @incrAnnotations = []
            @groups = []
            @definitions = {}
            @name = name
            
            errors = 0
            
            # populate table of definitions
            # gather list of groups and incrAnnotations
            # set namespace reference in each def
            defs.each do |d|
                if d.is_a? IncrementalAnnotation
                    @incrAnnotations << d
                else
                    if @definitions[d.nameWithID.name]
                        puts "#{d.location} error: duplicate definition name"
                        puts "info: name first defined at #{definitions[d.nameWithID.name].location}"
                        errors += 1
                    else
                        @definitions[d.nameWithID.name] = d
                        if d.is_a? Group
                            @groups << d
                        end
                        d.namespace = self           
                    end                    
                end
            end

            if errors > 0
                raise
            end
            
        end

        # @param namespace [Namespace]
        def merge!(namespace)
            if namespace.name == @name
                @incrAnnotations.concat(namespace.incrAnnotations)
                definitions.each do |d|
                    if @definitions[d.nameWithID.name]
                        puts "#{d.location} error: duplicate definition name"
                        puts "info: name first defined at #{definitions[d.nameWithID.name].location}"
                        errors += 1
                    else
                        @definitions[d.nameWithID.name] = d
                        if d.is_a? Group
                            @groups << d
                        end                        
                    end                    
                end
            else
                raise "error: cannot merge different namespaces"
            end
        end

        # @param schema [Schema] common schema
        # @param stack [Array] used to detect cycles
        def link(schema, stack=[])
            if @schema.nil?
                errors = 0
                @definitions.each do |name, d|
                    if !d.link(schema, stack.dup << self)
                        errors += 1
                    end                    
                end
                if errors == 0
                    @schema = schema
                end
            end
            @schema
        end

        # @param name [String] unqualified name
        # @return [Definition,Group]
        def resolve(name)
            @definitions[name]
        end

        # @private
        #
        def lookup(reference)
            fields = reference.split(".")
            case fields.size
            when 1
                @definitions[fields.first]
            else
                f = @definitions[fields.first]
                

                
                loop do
                    if d
                        case d.class
                        when Group
                            
                        when Definition

                
            
                fields.each do |f|                    
                end
            end
        end

    end    

end



