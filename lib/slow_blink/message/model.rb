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

            # @param schema [Schema]
            # @param opts [Hash]
            def initialize(schema, **opts)

                @schema = schema
                @groups = {}
                
                schema.groups.each do |name, g|
                    @groups[name] = model_group(g)
                end

            end

            # @param input [String] compact form
            # @return [Model::Group] decoded instance
            def from_compact!(input)
                raise
            end

            attr_reader :groups
                
            # @return [Class]
            def model_type(type)                
                klass = Class.new do
                    include SlowBlink::Message.const_get(type.class.name.split('::').last)
                end                        
            end

            # @return [Class]
            def model_field(field)
                klass = model_type(field.type).class_eval do
                    @opt = field.opt?
                    @name = field.nameWithID.name
                    @id = field.nameWithID.id
                    def self.opt?
                        @opt
                    end
                    def self.name
                        @name
                    end
                    def self.id
                        @id
                    end
                    include SlowBlink::Message::Field
                end
                
            end

            # @return [Class]
            def model_group(group)
                this = self
                klass = Class.new do
                    @name = group.nameWithID.name
                    @id = group.nameWithID.id
                    @fields = []
                    def self.fields
                        @fields
                    end
                    include SlowBlink::Message::Group
                    group.fields.each do |f|
                        @fields << this.model_field(f)
                    end
                end               
            end
            
        end

    end

end

require "slow_blink/message/integer"
require "slow_blink/message/string"
require "slow_blink/message/binary"
require "slow_blink/message/boolean"
require "slow_blink/message/enumeration"
require "slow_blink/message/float"
require "slow_blink/message/sequence"
require "slow_blink/message/field"
require "slow_blink/message/group"
require "slow_blink/message/time"
require "slow_blink/message/time_of_day"

