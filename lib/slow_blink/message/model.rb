# @license
#   
#   Copyright (c) 2016 Cameron Harper
#    
#   Permission is hereby granted, free of charge, to any person obtaining a copy of
#   this software and associated documentation files (the "Software"), to deal in
#   the Software without restriction, including without limitation the rights to
#   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
#   the Software, and to permit persons to whom the Software is furnished to do so,
#   subject to the following conditions:
#   
#   The above copyright notice and this permission notice shall be included in all
#   copies or substantial portions of the Software.
# 
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
#   FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
#   COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


module SlowBlink

    # This module is concerned with generating models from Schema that are optimised for encoding/decoding and enforcing constraints
    module Message

        # Trying to encode a group which has one or more uninitialised non-optional fields
        class IncompleteGroup < EncodingError
        end

        # Trying to encode a group which does not have an ID
        class UntaggedGroup < EncodingError
        end

        # Trying decode a message that has more than {Model#maxRecursion} levels of nesting
        class RecursionLimit < EncodingError
        end

        # extra bytes exist after sequence of extension groups but before end of container group
        class ExtensionPadding < EncodingError
        end

        # exponent is not null but mantissa is
        class NullMantissa < EncodingError
        end

        # Blink Specification: strong (encoding) errors are caused by constraints that *must* be checked
        class StrongError < EncodingError
        end

        # Blink Specification: weak (encoding) errors are caused by constraints that *may* be checked
        class WeakError < EncodingError
        end

        class StrongError1 < StrongError
        end
        
        class WeakError1 < WeakError
        end
        class WeakError2 < WeakError            
        end
        class WeakError3 < WeakError
        end
        class WeakError4 < WeakError
        end
        class WeakError5 < WeakError
        end
        class WeakError6 < WeakError
        end
        class WeakError7 < WeakError
        end
        class WeakError8 < WeakError
        end
        class WeakError9 < WeakError
        end
        class WeakError10 < WeakError
        end
        class WeakError11 < WeakError
        end
        class WeakError12 < WeakError
        end
        class WeakError13 < WeakError
        end
        class WeakError14 < WeakError
        end
        class WeakError15 < WeakError
        end

        # Use Model to create message models from a {Schema}
        class Model

            # the maximum level of nesting in messages able to be decoded by models
            DEFAULT_MAX_RECURSION = 100

            # @return [Integer]
            attr_reader :maxRecursion

            # @api user
            #
            # Generate a Model from a {Schema}
            #
            # @param schema [SlowBlink::Schema]
            # @param opts [Hash] options
            #
            # @option opts [Integer] :maxRecursion
            #
            def initialize(schema, **opts)

                @schema = schema
                @taggedGroups = {}
                @groups = {}
                @maxRecursion = opts[:maxRecursion]||DEFAULT_MAX_RECURSION
                maxRecursion = @maxRecursion

                # any of the groups
                
                taggedGroups = @taggedGroups
                
                @anyTaggedGroup = Class.new(DynamicGroup) do
                    @maxRecursion = maxRecursion
                    @anyTaggedGroup = self
                    @taggedGroups = taggedGroups
                    @permittedID = schema.groups.map{|g|g.id}.select{|g|g}
                end
                    
                anyTaggedGroup = @anyTaggedGroup
                
                # create an anon class for each group defined in schema                
                schema.groups.each do |g|
                    fields = g.fields.map{|f| _model_field(f)}
                    @groups[g.name] = Class.new(Group) do
                        @maxRecursion = maxRecursion
                        @anyTaggedGroup = anyTaggedGroup                        
                        @name = g.name
                        @id = g.id
                        @fields = fields
                    end
                    if g.id
                        @taggedGroups[g.id] = @groups[g.name]
                    end
                end

            end

            # @api user
            #
            # Initialise a {Group} from a compact form string
            # @param input [StringIO] Blink Protocol compact form
            # @return [Group] anonymous subclass instance of Group
            # @raise [WeakError,StrongError]
            # @raise [RecursionLimit]
            def decode_compact(input)
                @anyTaggedGroup.from_compact(input, []).get
            end

            # @api user
            #
            # Get a {Group} by name
            #
            # @param name [String] name of group (may be qualified)
            # @return [Group] anonymous subclass of Group
            # @raise [RangeError] unknown group
            def group(name)
                if (group = @groups[name]).nil?
                    raise RangeError.new "group '#{name}' is unknown"
                else
                    group
                end                
            end

            private

                # Create a model for a Field
                #
                # @param field [SlowBlink::Field] field definition
                # @return [Class] anonymous subclass of {Field}
                def _model_field(field)

                    type = _model_type(field.type)
                    Class.new(Field) do
                        @optional = field.optional?
                        @name = field.name
                        @id = field.id
                        @type = type
                        @sequence = field.type.sequence?                        
                    end
                end

                # Create a model for a type
                #
                # @param type [SlowBlink::Type] type definition
                # @param opt  [true,false] parent definition may allow this type to be optional
                def _model_type(type)
                    anyTaggedGroup = @anyTaggedGroup
                    maxRecursion = @maxRecursion

                    case type.class
                    when SlowBlink::OBJECT
                        @anyTaggedGroup                    
                    when SlowBlink::DynamicGroup
                        taggedGroups = @taggedGroups
                        Class.new(DynamicGroup) do
                            @anyTaggedGroup = anyTaggedGroup
                            @maxRecursion = maxRecursion
                            @taggedGroups = taggedGroups
                            @permittedID = type.groups.map{|g|g.id}
                        end
                    when SlowBlink::StaticGroup
                        fields = type.fields.map{|f| _model_field(f)}
                        Class.new(StaticGroup) do
                            @maxRecursion = maxRecursion                 
                            @name = type.name
                            @id = type.id
                            @fields = fields                          
                        end                                                                           
                    else                    
                        Class.new(SlowBlink::Message.const_get(type.class.name.split('::').last)) do
                            @type = type                                       
                        end                    
                    end
                end

        end

    end

end

require "stringio"
require "slow_blink/message/ext_compact_encoder"
require "slow_blink/message/field"
require "slow_blink/message/integer"
require "slow_blink/message/string"
require "slow_blink/message/binary"
require "slow_blink/message/fixed"
require "slow_blink/message/boolean"
require "slow_blink/message/enum"
require "slow_blink/message/floating_point"
require "slow_blink/message/group"
require "slow_blink/message/time"
require "slow_blink/message/time_of_day"
require "slow_blink/message/date"
require "slow_blink/message/decimal"

