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
                raise ArgumentError.new "at least one file required"                
            end
        end

        # @api user
        #
        # @return [Array<Group>] groups
        def groups
            @defs.values.select do |d|
                d.is_a? Group
            end
        end

        # @api user
        #
        # @return [Array<Definition,Group>] definitions
        def definitions
            @defs.values
        end

        # @api user
        #
        # Create a Schema from one or more Blink Protocol schemas
        #
        # @param buffer [Array<SchemaBuffer,String>]
        def initialize(*buffer)

            namespace = []

            if buffer.size > 0
                buffer.each do |b|
                    if buffer.kind_of? String
                        namespace << SlowBlink.parse_file_buffer(buffer)
                    else
                        namespace << SlowBlink.parse_file_buffer(b.buffer, filename: b.filename)
                    end
                end
            else
                raise ArgumentError.new "at least one buffer required"
            end

            @defs = {}

            # create groups and definitions
            namespace.each do |ns|    
                ns[:defs].select{|d|d[:class] != :IncrementalAnnotation}.each do |d|
                    key = d[:name][:name].dup
                    if ns[:name]
                        key.prepend "#{ns[:name]}::"
                    end
                    if @defs[key]
                        raise ParseError.new "#{d[:loc]}: duplicate definition: '#{key}' first defined at '#{@defs[key].location}'"
                    else
                        @defs[key] = SlowBlink.const_get(d[:class]).new(d.merge({:ns=>ns[:name], :table=>@defs}))
                    end
                end                
            end

            # test that reference definitions resolve and detect circular references
            @defs.values.each do |d|
                if d.is_a? Definition and d.type.is_a? REF
                    ptr = d.type.resolve
                    if ptr        
                        stack = [d]
                        while ptr and ptr.is_a? Definition and ptr.type.is_a? REF do
                            if stack.include? ptr
                                raise ParseError.new "#{d.type.location}: '#{d.name}' resolves to a circular reference"
                            else
                                ptr = ptr.type.resolve
                            end
                        end
                    else
                        raise ParseError.new "#{d.type.location}: '#{d.name}' does not resolve"
                    end
                end
            end

            # test that groups resolve and meet constraints
            tagged = {}
            @defs.values.each do |d|                
                if d.is_a? Group
                    d.superGroup
                    d.fields
                    if d.id and tagged[d.id]
                        raise ParseError.new "#{d.type.location}: duplicate tag"
                    else
                        tagged[d.id] = d
                    end                    
                end
            end

        end

    end    

end

require 'slow_blink/parse_error'
require 'slow_blink/log'
require 'slow_blink/schema_buffer'
require 'slow_blink/version'
require 'slow_blink/field'
require 'slow_blink/type'
require 'slow_blink/static_group'
require 'slow_blink/dynamic_group'
require 'slow_blink/integer'
require 'slow_blink/decimal'
require 'slow_blink/floating_point'
require 'slow_blink/string'
require 'slow_blink/binary'
require 'slow_blink/fixed'
require 'slow_blink/date'
require 'slow_blink/time_of_day'
require 'slow_blink/time'
require 'slow_blink/ref'
require 'slow_blink/group'
require 'slow_blink/object'
require 'slow_blink/boolean'
require 'slow_blink/enum'
require 'slow_blink/sym'
require 'slow_blink/definition'
require 'slow_blink/ext_schema_parser'



