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

    # Blink Specification 3.12
    class SEQUENCE < Type

        # @return [Type]
        attr_reader :type

        # @private
        #
        # @param type [Type] repeating type
        # @param location [String]    
        def initialize(type, location)
            @type = nil
            @rawType = type
            super(location)
        end

        # @private
        #
        # @macro common_link
        def link(schema, stack=[])
            if @schema.nil?
                case @rawType.class
                when REF
                    schema.definition(@rawType)
                when SEQUENCE
                    puts "error: sequence of sequence is not permitted"
                else
                    @type = @rawType
                    @schema = schema
                end
            end
            @schema
        end

        # @private
        def to_compact(input, **opts)
            if input.kind_of? Array
                input.inject(CompactEncoder::putU32(input.size)) do |out, v|
                    out << @type.to_compact(v)
                end
            elsif opts[:optional] and input.nil?
                out = CompactEncoder::putU32(input)
            else
                raise Error.new "expecting an Array, got a '#{input.class}'"
            end                
        end

    end

end
