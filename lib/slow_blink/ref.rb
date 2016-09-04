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

    class REF < Type

        # @return referenced object
        attr_reader :ref

        # @return [true] dynamic group reference
        # @return [false] static reference
        def dynamic?
            @dynamic
        end

        # @private
        #
        # @param qname [String] 
        # @param dynamic [true,false]
        # @param location [String]    
        def initialize(qname, dynamic, location)
            @qname = qname
            if qname.split(":").size == 1
                @namespace = nil
                @name = qname                
            else                
                @namespace = qname.split(":").first
                @name = qname.split(":").last
            end
            @dynamic = dynamic
            @ref = nil
            super(location)
        end

        

        # @private
        # 
        # @macro common_link
        def link(schema, ns, stack=[])
            if @schema.nil?
                if @namespace
                    ref = schema.resolve(@namespace, @name)                    
                else
                    ref = ns.resolve(@name) or schema.resolve(@namespace, @name)
                end
                if ref and ref.link(schema, stack << self)
                    # follow reference to get type
                    loop do
                        if ref.kind_of? Definition and ref.type.kind_of? REF
                            ref = ref.type.ref
                        else
                            if !ref.kind_of? Group
                                ref = ref.type
                            end
                            break
                        end
                    end
                    if @dynamic and !ref.kind_of? Group
                        puts "#{@location}: error: '#{@qname} *' must resolve to a Group"
                    else
                        @ref = ref
                        @schema = schema
                    end
                else                    
                    puts "#{@location}: error: '#{@qname}' is not defined in schema"
                end                
            end
            @schema
        end
        
    end

end

