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

    # Blink Specification 7.3
    class IncrementalAnnotation

        include Enumerable

        attr_reader :ref

        def type?
            @type
        end

        attr_reader :name

        attr_reader :location

        def each(&block)
            @annotes.each(&block)
        end

        def initialize(attr)
            @ns = attr[:ns]
            @ref = attr[:ref]
            @type = attr[:type]
            @name = attr[:name]||false
            @location = attr[:loc]
            @annotes = []
            attr[:annotes].each do |a|
                if a.is_a? Hash
                    @annotes << {a[:key] => a[:value]}
                elsif a.kind_of? Integer
                    @annotes << a
                end                
            end
        end

    end
    
end
