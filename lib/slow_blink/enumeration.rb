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

    class Enumeration

        include Annotatable

        # @private
        #
        # @param syms [Array<Sym>] symbol list
        def initialize(syms)
            @annotes = {}
            @rawSyms = syms
            @syms = {}
            @schema = nil       
        end


        # @private
        #
        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                @schema = nil
                value = 0
                errors = 0
                @syms = {}                        
                @rawSyms.each do |s|
                    if @syms[s.name]
                        puts "#{s.location} error: duplicate name"
                        errors += 1
                    else
                        if s.val
                            if @syms.values.include? s.val
                                puts "#{s.location} error: duplicate value"
                                errors += 1
                            else
                                value = s.val + 1
                            end                        
                        else
                            s.val = value                            
                            value += 1
                        end
                        @syms[s.name] = s
                    end
                end
                if errors == 0
                    @schema = schema
                end
            end
            @schema            
        end

        # @param nameOrVal [String,Integer]
        # @return [Sym]
        # @return [nil]
        def symbol(nameOrVal)
            if nameOrVal.kind_of? String
                @syms[nameOrVal]
            else
                @syms.detect{|s|s.val == nameOrVal.to_i}
            end
        end

        # @private
        def validate(input)
            if symbol(input)
               true
            else
                raise
            end
        end

        # @private
        def encode_compact(value, **opts)
            if opts[:opt]
                putPresent + CompactEncoder::putVLC(self.symbol(value).val)
            else
                CompactEncoder::putVLC(self.symbol(value).val)
            end
        end

    end
end
