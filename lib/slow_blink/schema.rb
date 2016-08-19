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

require 'slow_blink/annotatable'

# @!macro [new] common_link
#   
#   Resolve symbols to definitions in schema
#
#   @param mod [Schema] module this type belongs to
#   @param stack [Array] call stack
#
#   @return [Schema] linked
#   @return [nil] not linked
#

module SlowBlink

    class Schema

        include Annotatable

        # @api Initialise a Schema object from Blink Schema input string 
        #
        # @param input [String] Blink schema (as string)
        # @return [Schema]
        def self.parse(input)
            SlowBlink::parseFileBuffer(input)
        end

        # @param namespace [nil,String]
        # @param defs [Array<Definition>]
        def initialize(namespace, defs)

            @annotes = []
            errors = 0

            if namespace
                @namespace = namespace
            else
                @namespace = nil
            end

            @defs = {}

            # populate table of definitions
            defs.each do |d|
                if !d.is_a? IncrementalAnnotation
                    if @defs[d.name]
                        puts "#{d.location}: error: duplicate definition name"
                        errors += 1
                    else
                        @defs[d.name] = d
                    end
                end
            end

            # now apply incremental annotation
            defs.each do |d|
                if d === IncrementalAnnotation
                    d.link(schema)
                end
            end

            # now link the definitions
            @defs.each do |name, d|
                if !d.link(self)
                    errors += 1
                end
            end
            
            if errors > 0
                raise Error.new "#{errors} errors"
            end
            
        end

        # @param name [String] name of definition
        # @return [Definition]
        # @return [Group]
        def symbol(name)
            @defs[name]            
        end
    
    end    

end

require 'slow_blink/error'
require 'slow_blink/version'
require 'slow_blink/location'
require 'slow_blink/annotation'
require 'slow_blink/incremental_annotation'
require 'slow_blink/group'
require 'slow_blink/field'
require 'slow_blink/component_reference'

require 'slow_blink/definition'

require 'slow_blink/type'

require 'slow_blink/enumeration'
require 'slow_blink/sym'

require 'slow_blink/name_with_id'

require 'slow_blink/parser'



