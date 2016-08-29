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

        class Model

            # Initialise a message model from a schema
            #
            # @param schema [Schema]
            # @param opts [Hash]
            def initialize(schema, **opts)
                @schema = schema
                @groups = {}                
                schema.taggedGroups.each do |id, g|
                    @groups[id] = model_group(false, g)
                end                
            end

            def from_compact(input)
                buf = SlowBlink::CompactEncoder::getBinary!(input)
                if buf.size > 0
                    id = SlowBlink::CompactEncoder::getU64!(buf)
                    group = @groups[id]                    
                    if group                        
                        group.from_compact!(buf)
                    else
                        raise Error.new "W2"    # type identifier not know to decoder
                    end
                else
                    raise Error.new "W1"    # size of zero
                end                    
            end

            # @param group [Group]
            def model_group(opt, group)
                this = self
                klass = Class.new do
                    @opt = opt
                    @name = group.nameWithID.name
                    @id = group.nameWithID.id
                    @fields = []
                    group.fields.each do |f|
                        @fields << this.model_field(f)
                    end
                    extend StaticGroup::CLASS
                    include StaticGroup::INSTANCE
                end
            end

            def model_field(field)
                this = self
                klass = Class.new do
                    @opt = field.opt?
                    @name = field.nameWithID.name
                    @id = field.nameWithID.id
                    @type = this.model_type(field.opt?, field.type)
                    @schema = field
                    include Field::INSTANCE
                    extend Field::CLASS
                end                
            end

            def model_type(opt, type)
                
                case type.class
                when SlowBlink::OBJECT
                    groups = @groups
                    permitted = @schema.taggedGroups.keys
                    klass = Class.new do
                        @opt = opt
                        @groups = groups
                        @permitted = permitted
                        extend SlowBlink::Message::DynamicGroup::CLASS
                        include SlowBlink::Message::DynamicGroup::INSTANCE
                    end                               
                when SlowBlink::REF
                    if type.ref.kind_of? Group
                        if type.dynamic?
                            groups = @groups
                            permitted = []
                            @schema.taggedGroups.each do |id, g|
                                if g.group_kind_of?(type)
                                    permitted << id
                                end
                            end
                            klass = Class.new do
                                @opt = opt
                                @groups = groups
                                @permitted = permitted
                                extend SlowBlink::Message::DynamicGroup::CLASS
                                include SlowBlink::Message::DynamicGroup::INSTANCE
                            end                               
                        else
                            model_group(opt, type.ref)
                        end
                    else
                        model_type(opt, type.ref)
                    end                        
                else                        
                    return Class.new do
                        @opt = opt
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

