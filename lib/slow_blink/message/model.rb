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

    # This module is concerned with generating models from Schema that are optimised for encoding/decoding and enforcing constraints
    module Message

        class Error < StandardError
        end

        class Model

            # the maximum level of nesting in messages able to be decoded by models
            DEFAULT_MAX_RECURSION = 100

            # @api user
            #
            # Create a Model from a {Schema}
            #
            # @param schema [SlowBlink::Schema]
            # @param opts [Hash]
            #
            # @option opts [Symbol] :maxRecursion
            #
            def initialize(schema, **opts)

                @schema = schema
                @taggedGroups = {}
                @groups = {}
                @maxRecursion = opts[:maxRecursion]||DEFAULT_MAX_RECURSION
                maxRecursion = @maxRecursion

                # define the extension object
                groups = @groups
                taggedGroups = @taggedGroups
                permitted = schema.tagged.keys
                @extensionObject = Class.new(DynamicGroup) do
                    @maxRecursion = maxRecursion
                    @extensionObject = self
                    @opt = false
                    @groups = groups
                    @taggedGroups = taggedGroups
                    @permitted = permitted                        
                end
                extensionObject = @extensionObject
                
                schema.groups.each do |name, g|
                    this = self
                    @groups[name] = Class.new(Group) do
                        @extensionObject = extensionObject
                        @maxRecursion = maxRecursion
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
            # @note return value will be an *anonymous* *subclass* *instance* of {Group}
            #
            # @param [String] Blink Protocol compact form
            # @return [Group] group instance
            #
            def decode_compact(input)
                stack = []
                inputSize = input.size
                buf = input.getBinary!
                if buf.size > 0
                    id = buf.getU64!
                    groupClass = @taggedGroups[id]
                    begin
                        if groupClass                        
                            group = groupClass.from_compact!(buf, stack)                        
                        else
                            raise Error.new "W2: Group id #{group.id} is unknown"
                        end
                    rescue Error => ex
                        puts ex
                        puts "encountered at offset #{inputSize - input.size}"
                        puts stack.last.name
                        raise
                    end
                else
                    raise Error.new "W1: Top level group cannot be null "                    
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
            # @param type [SlowBlink::Type] type definition
            # @param opt  [true,false] parent definition may allow this type to be optional
            #
            #            
            def _model_type(type, opt)
                this = self
                extensionObject = @extensionObject
                maxRecursion = @maxRecursion
                case type.class
                when SlowBlink::OBJECT
                    groups = @groups
                    taggedGroups = @taggedGroups
                    permitted = @taggedGroups.keys
                    Class.new(DynamicGroup) do
                        @extensionObject = extensionObject
                        @maxRecursion = maxRecursion
                        @opt = opt
                        @groups = groups
                        @taggedGroups = taggedGroups
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
                                @extensionObject = extensionObject
                                @maxRecursion = maxRecursion
                                @opt = opt
                                @taggedGroups = taggedGroups
                                @groups = groups
                                @permitted = permitted
                            end                               
                        else
                            Class.new(StaticGroup) do
                                @extensionObject = extensionObject
                                @maxRecursion = maxRecursion
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
                        @maxRecursion = maxRecursion
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

require "slow_blink/message/ext_compact_encoder"
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
require "slow_blink/message/date"
require "slow_blink/message/decimal"

