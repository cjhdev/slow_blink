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

# SlowBlink
module SlowBlink

    module CompactEncoder

        # @return [String]
        def self.putNull
            "\x40"
        end
        
        # @return [String]
        def self.putPresent
            "\x01"
        end

        def self.putBool(value)
            (value) ? "\x01" : "\x00"
        end

        # @param value [Float]
        # @return [String]
        def self.putF64(value)
            putVLC([value].pack("G").unpack("Q<").first)
        end

        def self.putString(value)
            putVLC(value.size) + value
        end

        def self.putBinary(value)
            putVLC(value.size) + value.to_s
        end

        def self.putFixed(value)
            value.to_s
        end


        

            
            # @private
            #
            # @param value [Integer] unsigned integer
            # @return [Integer] bytes to encode as VLC
            def self.getSizeUnsigned(value)                
            end

            # @private
            #
            # @param value [Integer] signed integer
            # @return [Integer] bytes to encode as VLC
            def self.getSizeSigned(value)                
            end

            # @private
            #
            # @param value [Integer] signed or unsigned integer
            # @param opts [Hash] option
            # @option opts [Symbol] :signed value is a signed integer
            def self.putVLC(value, **opts)
                bytes = opts[:signed] ? getSizeSigned(value) : getSizeUnsigned(value)
                case bytes
                when 1
                    [value].pack("C")
                when 2
                    [0x80 | value].pack("S<")
                else
                    out = [0xc0 | bytes]
                    while out.size < (bytes - 1) do
                        out << (value >> 8)
                    end
                    out.pack("S<C#{bytes-2}")                                                        
                end                    
            end
    end

end
