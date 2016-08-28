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

# @!macro [new] common_link
#   
#   Resolve references within schema
#
#   @param schema [Schema] schema to link
#   @param stack [Array]
#
#   @return [Schema] linked
#   @return [nil] not linked
#

module SlowBlink

    class Schema

        # @!method self.parse(input, **opts)
        #
        #   Initialise a Schema object from Blink Schema input string
        #
        #   @param input [String] Blink Schema
        #   @param opts [Hash] options
        #   @option opts [String] :fileName filename to append to error message strings
        #   @return [Schema]
        def self.parse
        end

        # Tagged groups are able to be serialised as dynamic groups
        #
        # @return [Array<Group>]
        attr_reader :taggedGroups
    
        # @private
        #
        # @param namespace [Array<Namespace>]
        def initialize(*namespace)

            @ns = {}
            @groups = {}
            
            errors = 1

            # gather and merge namespaces
            namespace.each do |ns|
                if @ns[ns.name]
                    begin
                        @ns[ns.name].merge!(ns)
                    rescue
                        errors += 1
                    end
                else
                    @ns[ns.name] = ns
                end
            end

            # apply incremental annotation in order of input
            namespace.each do |ns|
                ns.incrAnnotations.each |a|
                    a.apply(self, ns)
                end
            end
            
            # gather tagged groups and detect duplicates
            @ns.each do |name, ns|
                ns.groups.each do |g|
                    if @taggedGroups[g.nameWithID.id]
                        puts "error: duplicate group id"
                        errors += 1
                    else
                        @taggedGroups[g.nameWithID.id] = g
                    end
                end
            end

            # resolve all references
            @ns.each do |name, ns|
                ns.link(self)
            end

            if errors > 0
                raise Error.new "#{errors} errors"
            end
            
        end

        # resolve a name to a definition in any namespace
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

require 'slow_blink/annotatable'
require 'slow_blink/namespace'
require 'slow_blink/error'
require 'slow_blink/compact_encoder'
require 'slow_blink/ext_compact_encoder'
require 'slow_blink/version'
require 'slow_blink/annotation'
require 'slow_blink/incremental_annotation'
require 'slow_blink/group'
require 'slow_blink/field'
require 'slow_blink/component_reference'
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



