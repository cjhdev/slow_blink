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

# @!macro [new] common_to_s
#   
#   @return [String] blink schema

module SlowBlink

    class Schema

        include Annotatable

        # @param namespace [nil,String] [\\]?[_a-zA-Z][_a-zA-Z0-9]*
        # @param defs [Array<Definition>]
        def initialize(namespace, defs)
            errors = 0

            if namespace
                @namespace = namespace.to_s
            else
                @namespace = nil
            end
                    
            @defs = []
            defs.each do |d|
                if d.link(self)
                    @defs << d
                else
                    errors = errors + 1
                end
            end
            if errors > 0
                raise Error
            end
        end

        def symbol(symbol)
            @defs.detect{|d|d.name == symbol}
        end

        def to_s
            out = ""
            if @namespace
                out << "namespace #{@namespace}"
            end
            @defs.each do |d|
                out << d.to_s
            end
            out
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



