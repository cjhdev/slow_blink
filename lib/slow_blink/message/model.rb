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

            # Initialise a message model from a schema
            #
            # @param schema [Schema]
            # @param opts [Hash]
            def initialize(schema, **opts)
                @schema = schema
                @groups = {}                
                schema.groups.each do |id, g|
                    @groups[id] = _model_group(false, g)                    
                end                
                groups = @groups
                @top = Class.new do
                    @opt = false
                    @groups = groups
                    @permitted = groups.keys
                    extend DynamicGroup::CLASS
                    include DynamicGroup::INSTANCE
                end                
            end

            def decode(input)
                input = input.dup
                @top.from_compact!(input)
            end

            def from_compact(input)
                @top.from_compact!(input)
            end

            def group(name, &block)
                group = @top.groups.values.detect{|g|g.name == name}
                if group                    
                    result = @top.new(group.new(nil))
                    result.instance_exec(&block)
                    result
                else
                    raise
                end
            end

            def new(&block)
                if block.nil?
                    raise                    
                end
                result = self.instance_exec(&block)
            end    

            # @param group [Group]
            def _model_group(opt, group)
                this = self
                klass = Class.new do
                    @name = group.nameWithID.name
                    @id = group.nameWithID.id
                    @opt = opt
                    @fields = group.fields.inject([]) do |fields, f|
                        fields << this._model_field(f)                        
                    end
                    extend StaticGroup::CLASS
                    include StaticGroup::INSTANCE
                end            
            end

            def _model_field(field)
                this = self
                klass = Class.new do
                    @opt = field.opt?
                    @name = field.nameWithID.name
                    @id = field.nameWithID.id
                    @type = this._model_type(field)
                    include Field::INSTANCE
                    extend Field::CLASS
                end                
            end

            def _model_type(field)
                type = field.type
                name = field.nameWithID.name    
                case type.class
                when SlowBlink::OBJECT
                    groups = @groups
                    permitted = @schema.groups.keys
                    klass = Class.new do
                        @opt = field.opt?
                        
                        @groups = groups
                        @permitted = permitted
                        extend DynamicGroup::CLASS
                        include DynamicGroup::INSTANCE
                    end                               
                when SlowBlink::REF
                    if type.ref.kind_of? Group
                        if type.dynamic?
                            groups = @groups
                            permitted = @schema.groups.keys
                            @schema.groups.each do |id, g|
                                if g.group_kind_of?(type)
                                    permitted << id
                                end
                            end
                            klass = Class.new do
                                @name = name
                                @opt = field.opt?
                                @groups = groups
                                @permitted = permitted
                                extend DynamicGroup::CLASS
                                include DynamicGroup::INSTANCE
                            end                               
                        else
                            _model_group(field.opt?, type.ref)
                        end
                    else
                        _model_type(opt, type.ref)
                    end                        
                else                        
                    return Class.new do
                        @opt = field.opt?
                        @name = name
                        @schema = type
                        extend SlowBlink::Message.const_get(type.class.name.split('::').last + "::CLASS")
                        include SlowBlink::Message.const_get(type.class.name.split('::').last + "::INSTANCE")
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

