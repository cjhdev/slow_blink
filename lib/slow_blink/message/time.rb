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

require 'time'

module SlowBlink::Message

    # @abstract
    class MILLI_TIME

        def self.type
            @type
        end

        # @private
        def self.from_compact(input, depth)
            if value = input.getI64
                self.new(value)
            else
                nil
            end
        end

        # @return [DateTime]
        def get
            @value
        end

        # @overload set(value)
        #   Set a millisecond time value
        #   @param value [Time,DateTime,Date]
        # @overload set(value)
        #   @param value [String] time in ISO 8601
        # @overload set(value)
        #   @param value [String] time in milliseconds since UNIX epoch
        # @raise [TypeError]
        # @raise [ArgumentError]
        def set(value)            
            if value.kind_of? Time or value.kind_of? DateTime or value.kind_of? Date
                @value = value.to_datetime
            elsif value.kind_of? String
                @value = DateTime.parse(value)
            elsif value.kind_of? Integer
                @value = DateTime.strptime(value.to_s, '%Q')
            else
                raise TypeError
            end                        
        end

        # @note calls {#set}(value)
        def initialize(value)
            set(value)            
        end

        # @private
        def to_compact(out)
            out.putI64(@value.strftime('%Q').to_i)            
        end

        def to_tag
            @value.to_s
        end
    
    end

    # @abstract
    class NANO_TIME < MILLI_TIME

        # @overload set(value)
        #   Set a nanosecond resolution time value
        #   @param value [Time,DateTime,Date]
        # @overload set(value)
        #   @param value [String] time in ISO 8601
        # @overload set(value)
        #   @param value [Integer] time in nanoseconds since UNIX epoch
        # @raise [TypeError]
        # @raise [ArgumentError]
        def set(value)            
            if value.kind_of? Time or value.kind_of? DateTime or value.kind_of? Date
                @value = time.to_datetime
            elsif value.kind_of? String
                @value = DateTime.parse(value)
            elsif value.kind_of? Integer
                @value = DateTime.strptime(value.to_s, '%N')
            else
                raise TypeError
            end                        
        end

        # @private
        def to_compact(out)
            out.putI64(@value.strftime('%N').to_i)
        end        
        
    end

end
