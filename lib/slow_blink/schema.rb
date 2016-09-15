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


# SlowBlink namespace
module SlowBlink

    # @!macro location
    #   Location string formatted as:
    #       [ FILENAME, ':' ], LINE_NUMBER, ':', COLUMN_NUMBER
    #   @return [String]
    
    class Schema

        # @api user
        # Create a Schema from one or more Blink Schema files that are evaluated
        # in the order they appear.
        #
        # @param filename [Array<String>]
        # @return [Schema]
        def self.read(*filename)
            input = []
            if filename.size > 0
                filename.each do |f|
                    input << SchemaBuffer.new(File.read(f), f)
                end
                self.new(*input)
            else
                raise "at least one file required"                
            end
        end

        # @api user
        #
        # @return [Hash<Group>] groups indexed by qualified name
        attr_reader :groups

        attr_reader :tagged
        
        # @return [Array<Namespace>]
        attr_reader :ns

        # @api user
        #
        # Create a Schema from one or more SchemaBuffers that are evaluated
        # in the order they appear.
        #
        # @param buffer [Array<SchemaBuffer>]
        def initialize(*buffer)

            if buffer.size > 0
                namespace = []
                buffer.each do |b|
                    namespace << Namespace.parse(b.buffer, filename: b.filename)                    
                end
            else
                raise "at least one buffer required"
            end

            @ns = {}
            @tagged = {}
            
            error = false          

            # gather and merge namespaces
            namespace.each do |ns|
                if @ns[ns.name]
                    begin
                        @ns[ns.name].merge!(ns)
                    rescue
                        raise
                    end
                else
                    @ns[ns.name] = ns
                end
            end

            # apply incremental annotation in order of input
            namespace.each do |ns|
                ns.incrAnnotations.each do |a|
                    a.apply(self, ns)
                end
            end
            
            # gather tagged groups and detect duplicates
            @ns.each do |name, ns|
                ns.groups.each do |g|
                    if g.nameWithID.id
                        if @tagged[g.nameWithID.id]
                            Log.error "error: groups that have identifiers must have unique identifiers ('#{@g.nameWithID.id}' was first assigned to '#{@tagged[g.nameWithID.id].nameWithID.name}' at #{@tagged[g.nameWithID.id].location}"
                            error = true
                        else
                            @tagged[g.nameWithID.id] = g
                        end
                    end
                end
            end

            # resolve all references
            @ns.each do |name, ns|
                if !ns.link(self)
                    error = true
                end
            end

            # create list of all groups with qualified names
            @groups = {}
            @ns.each do |name, ns|
                ns.groups.each do |g|
                    if name
                        @groups[g.nameWithID.name.prepend "#{name}:"] = g
                    else
                        @groups[g.nameWithID.name] = g
                    end                
                end
            end

            if error
                raise
            end
            
        end

        # Resolve a name to a definition in any namespace
        #
        # @param namespace [String,nil]
        # @param name [String]
        # @return [Definition,Group]
        def resolve(namespace, name)
            if @ns[namespace]
                @ns[namespace].resolve(name)
            else
                nil
            end               
        end
    
    end    

end

require 'slow_blink/log'
require 'slow_blink/schema_buffer'
require 'slow_blink/annotatable'
require 'slow_blink/namespace'
require 'slow_blink/error'
require 'slow_blink/version'
require 'slow_blink/annotation'
require 'slow_blink/incremental_annotation'
require 'slow_blink/group'
require 'slow_blink/field'
require 'slow_blink/definition'
require 'slow_blink/type'
require 'slow_blink/integer'
require 'slow_blink/decimal'
require 'slow_blink/floating_point'
require 'slow_blink/string'
require 'slow_blink/binary'
require 'slow_blink/fixed'
require 'slow_blink/date'
require 'slow_blink/time_of_day'
require 'slow_blink/time'
require 'slow_blink/sequence'
require 'slow_blink/ref'
require 'slow_blink/object'
require 'slow_blink/boolean'
require 'slow_blink/enumeration'
require 'slow_blink/sym'
require 'slow_blink/name_with_id'
require 'slow_blink/ext_schema_parser'



