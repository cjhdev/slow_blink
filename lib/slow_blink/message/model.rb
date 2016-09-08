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

        class Error < Exception
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
                schema.tagged.each do |id, g|
                    @taggedGroups[id] = _model_group(false, g)                    
                end                
                taggedGroups = @taggedGroups
                @top = Class.new(DynamicGroup) do
                    @opt = false
                    @groups = taggedGroups
                    @permitted = taggedGroups.keys                    
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
                @top.from_compact!(input.dup)
            end

            # @api user
            #
            # Create an instance of a group subclass
            #
            # @note return value will be an *anonymous* *subclass* *instance* of {DynamicGroup} or {StaticGroup}
            #
            # @overload group(name, data)
            #           
            #   @param name [String] name of group
            #   @param data [Hash] bulk initialisation data
            #   @return [StaticGroup,DynamicGroup] group instance
            #
            # @overload group(name)
            #   
            #   @param name [String] name of group
            #   @yield [Group] group instance to initalise
            #   @return [StaticGroup,DynamicGroup] group instance            
            #
            def group(name, data=nil, &block)
                group = @top.groups.values.detect{|g|g.name == name}
                if group                    
                    top = @top.new(group.new(data))
                    if block
                        self.instance_exec(top, &block)
                        # validate optional constraint here
                    end
                    top
                else
                    raise
                end
            end

            # @api private
            #
            # Create a model for a Group
            #
            # @param opt [true,false] this group is allowed to be optional
            # @param group [SlowBlink::Group] group definition
            # @return [Class] anonymous subclass of {StaticGroup}
            def _model_group(opt, group)
                this = self
                Class.new(StaticGroup) do
                    @implements = group.class
                    @name = group.nameWithID.name
                    @id = group.nameWithID.id
                    @opt = opt
                    @fields = group.fields.inject([]) do |fields, f|
                        fields << this._model_field(f)                        
                    end
                    
                end            
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
                    @implements = field.class
                    @opt = field.opt?
                    @name = field.nameWithID.name
                    @id = field.nameWithID.id
                    @type = this._model_type(field)
                end                
            end

            # @api private
            #
            # Create a model for a type
            #
            # @param field [SlowBlink::Field] field definition (containing type)
            # @return [Class] anonymous subclass
            def _model_type(field)
                type = field.type
                name = field.nameWithID.name    
                case type.class
                when SlowBlink::OBJECT
                    groups = @groups
                    permitted = @schema.tagged.keys
                    klass = Class.new(DynamicGroup) do
                        @implements = type.class
                        @opt = field.opt?                        
                        @groups = groups
                        @permitted = permitted                        
                    end                               
                when SlowBlink::REF
                    if type.ref.kind_of? Group
                        if type.dynamic?
                            groups = @groups
                            permitted = @schema.tagged.keys
                            @schema.tagged.each do |id, g|
                                if g.group_kind_of?(type)
                                    permitted << id
                                end
                            end
                            Class.new(DynamicGroup) do
                                @implements = type.class
                                @name = name
                                @opt = field.opt?
                                @groups = groups
                                @permitted = permitted
                            end                               
                        else
                            _model_group(field.opt?, type.ref)
                        end
                    else
                        _model_type(opt, type.ref)
                    end
                else                        
                    Class.new(SlowBlink::Message.const_get(type.class.name.split('::').last)) do
                        klass = 
                        @opt = field.opt?
                        @name = name
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
require "slow_blink/message/date"

