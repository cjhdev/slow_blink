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

    class Definition

        # @return [Type] defined type
        attr_reader :type

        # @macro location
        attr_reader :location

        # @return [String]
        attr_reader :name

        # @return [Integer,nil]
        attr_reader :id

        def self.===(other)
            self == other                
        end

        # @private
        def initialize(attr)
            @location = attr[:loc].freeze
            @ns = attr[:ns].freeze
            @name = attr[:name][:name].dup
            if @ns
                @name.prepend "#{@ns}:"
            end
            @name.freeze
            @id = attr[:name][:id]
            @type = SlowBlink.const_get(attr[:type][:class]).new(attr[:type].merge({:table => attr[:table], :ns => attr[:ns], :name => @name}))
        end

    end
end
