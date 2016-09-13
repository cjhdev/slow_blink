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

    module Message

        class Error < StandardError
        end

        class DecodeError
        end

        class Model

            # @api user
            #
            # Create a Model from a {Schema}
            #
            # @param schema [SlowBlink::Schema]
            def initialize(schema)
                @schema = schema
                @taggedGroups = {}
                @groups = {}
                schema.groups.each do |name, g|
                    this = self
                    @groups[name] = Class.new(Group) do
                        @name = g.nameWithID.name
                        @id = g.nameWithID.id
                        @fields = {}
                        g.fields.each do |f|
                            @fields[f.nameWithID.name] = this._model_field(f)
                        end                   
                    end
                    if g.nameWithID.id
                        @taggedGroups[g.nameWithID.id] = @groups[name]
                    end
                end                          
            end

            # @api user
            #
            # Initialise a message model instance with a compact form string
            #
            # @note return value will be an *anonymous* *subclass* *instance* of {DynamicGroup}
            #
            # @param [String] Blink Protocol compact form
            # @return [DynamicGroup] group instance
            #
            def decode_compact(input)
                buf = input.getBinary!
                if buf.size > 0
                    id = buf.getU64!
                    groupClass = @taggedGroups[id]
                    if groupClass
                        puts groupClass
                        group = groupClass.from_compact!(buf)                        
                    else
                        raise Error.new "W2: Group id #{group.id} is unknown"
                    end
                else
                    raise Error.new "W1: Top level group cannot be null"                    
                end
            end

            # @api user
            #
            # Get a group model
            #
            # @param name [String] name of group (may be qualified)
            # @return [Class] {DynamicGroup} or {Group}
            # @return [nil] group not defined
            #
            def group(name)
                @groups[name]            
            end

            # @api private
            #
            # Create a model for a Field
            #
            # @param field [SlowBlink::Field] field definition
            # @return [Class] anonymous subclass of {Field}
            def _model_field(field)
                this = self
                Class.new(Field) do
                    @opt = field.opt?
                    @name = field.nameWithID.name
                    @id = field.nameWithID.id
                    @type = this._model_type(field.type, field.opt?)
                end                
            end

            # @api private
            #
            # Create a model for a type
            #
            
            def _model_type(type, opt)
                this = self
                case type.class
                when SlowBlink::OBJECT
                    groups = @groups
                    taggedGroups = @taggedGroups
                    permitted = @taggedGroups.keys
                    Class.new(DynamicGroup) do
                        @opt = opt
                        @groups = groups
                        @permitted = permitted                        
                    end                     
                when SlowBlink::REF
                    if type.ref.kind_of? SlowBlink::Group
                        if type.dynamic?
                            taggedGroups = @taggedGroups
                            groups = @groups
                            permitted = @taggedGroups.keys
                            @schema.tagged.each do |id, g|
                                if g.group_kind_of?(type)
                                    permitted << id
                                end
                            end
                            Class.new(DynamicGroup) do
                                @opt = opt
                                @taggedGroups = taggedGroups
                                @groups = groups
                                @permitted = permitted
                            end                               
                        else
                            Class.new(StaticGroup) do
                                @name = type.ref.nameWithID.name
                                @id = nil
                                @opt = opt
                                @fields = {}
                                type.ref.fields.each do |f|
                                    @fields[f.nameWithID.name] = this._model_field(f)
                                end                                                            
                            end                                                   
                        end
                    else
                        _model_type(type.ref)
                    end
                when SlowBlink::SEQUENCE
                    Class.new(SEQUENCE) do
                        @type = this._model_type(type.type, false)
                    end                    
                else
                    Class.new(SlowBlink::Message.const_get(type.class.name.split('::').last)) do
                        @opt = opt
                        @type = type                                        
                    end                    
                end
            end

        end

    end

end

require "slow_blink/message/field"
require "slow_blink/message/integer"
require "slow_blink/message/string"
require "slow_blink/message/binary"
require "slow_blink/message/fixed"
require "slow_blink/message/boolean"
require "slow_blink/message/enumeration"
require "slow_blink/message/floating_point"
require "slow_blink/message/sequence"
require "slow_blink/message/group"
require "slow_blink/message/time"
require "slow_blink/message/time_of_day"
require "slow_blink/message/decimal"

