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

    # A REF is a type that points to a Group or a Definition
    # by a reference string.
    #
    #
    class REF < Type

        # @return [String]
        attr_reader :ref

        # @return [true,false]
        def dynamic?
            @dynamic
        end

        # @return [Group, Definition]
        def resolve
            result = nil
            if @table
                #Log.info "try to resolve #{@ref}"
                if (result = @table[@ref]).nil?                    
                    if @ns and @ref.split("::").size == 1
                        result = @table[@ns + "::" + @ref]
                        #Log.info "try to resolve #{@ns + "::" + @ref}"
                    end
                end                
            end
            result
        end                    

        # @private
        def initialize(attr)
            super(attr)
            @ref = attr[:ref].freeze
            @dynamic = attr[:dynamic]            
            @table = attr[:table]
        end
        
    end

end

