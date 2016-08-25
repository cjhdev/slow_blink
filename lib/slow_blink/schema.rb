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

        include Annotatable

        # @!method self.parse(input, **opts)
        #
        #   Initialise a Schema object from Blink Schema input string
        #
        #   @param input [String] Blink Schema
        #   @param opts [Hash] options
        #   @option opts [String] :fileName filename to append to error message strings
        #   @return [Schema]

        # @private
        #
        # @param namespace [nil,String]
        # @param defs [Array<Definition>]
        def initialize(namespace, defs)
            @nameWithID = NameWithID.new(nil,nil)
            @annotes = {}
            @groups = {}
            @defs = {}
            @groupsByID = {}
            
            errors = 0
            
            if namespace
                @namespace = namespace
            else
                @namespace = nil
            end

            # populate table of definitions
            # keep a separate table for groups
            defs.each do |d|
                if !d.is_a? IncrementalAnnotation
                    if @defs[d.nameWithID.name]
                        puts "#{d.location} error: duplicate definition name"
                        errors += 1
                    else
                        @defs[d.nameWithID.name] = d
                        if d.is_a? Group
                            @groups[d.nameWithID.name] = d
                            @groupsByID[d.nameWithID.id] = d
                        end                        
                    end                    
                end
            end

            # now apply incremental annotation
            @defs.each do |d|
                if d.is_a? IncrementalAnnotation
                    d.link(self)
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

        # @param name [String] definition or group name
        # @return [Definition]
        # @return [Group]
        def definition(name)
            @defs[name]            
        end

        # @param nameOrID [String,Integer] group name or id
        # @return [Group] group exists
        # @return [nil] group does not exist
        def group(nameOrID)
            if nameOrID.kind_of? String
                @groups[nameOrID]
            else
                @groupsByID[nameOrID]                
            end
        end

        # @param input [Hash,Array<Hash>] Blink JSON format input to serialise
        # @return [String] compact binary format
        # @raise [Error] type not found
        def to_compact(input)
            if input.kind_of? Hash
                input = [input]
            end
            begin                
                input.inject("") do |out, d|
                    type = d["$type"]
                    if type
                        group = @groups[type]
                        if group
                            out << group.to_compact(d, dynamic: true)
                        else
                            raise Error.new "group '#{type}' not defined on top level schema"
                        end
                    else
                        raise Error.new "top level '$type' field is missing"
                    end
                end
            rescue Error => ex
                puts "to_compact: error at #{ex}"
                raise
            end                
        end

        # @param input [String] Blink compact form
        # @return [Array<Hash>] Blink JSON form
        # @raise [Error]
        def from_compact(input)
            compact = input.dup
            out = []
            while compact.size > 0 do
                groupField = CompactEncoder::getBinary!(compact)
                if groupField.nil?
                    raise Error.new "strong error? group is nil"
                elsif groupField.size == 0
                    raise Error.new "W1"
                else
                    type = CompactEncoder::getU64!(groupField)
                    if type.nil?
                        raise Error.new "strong error? type tag is nil"
                    else
                        group = self.group(type)
                        if group.nil?
                            raise Error.new "W2"
                        else
                            out << group.from_compact!(groupField)
                        end                            
                    end
                end
            end
            out               
        end

    end    

end

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
require 'slow_blink/float'
require 'slow_blink/string'
require 'slow_blink/binary'
require 'slow_blink/fixed'
require 'slow_blink/date'
require 'slow_blink/time_of_day_milli'
require 'slow_blink/time_of_day_nano'
require 'slow_blink/nano_time'
require 'slow_blink/milli_time'
require 'slow_blink/sequence'
require 'slow_blink/ref'
require 'slow_blink/object'
require 'slow_blink/boolean'
require 'slow_blink/enumeration'
require 'slow_blink/sym'
require 'slow_blink/name_with_id'
require 'slow_blink/ext_schema_parser'



