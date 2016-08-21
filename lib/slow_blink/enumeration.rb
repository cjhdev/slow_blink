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
        extend CompactEncoder

        # @private
        #
        # @param syms [Array<Sym>] symbol list
        def initialize(syms)
            @annotes = {}
            @rawSyms = syms
            @syms = {}
            @schema = nil       
        end

        def ===(other)
            self.class == other.class            
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
                        puts "#{s.location}: error: duplicate name"
                        errors += 1
                    else
                        if s.val
                            if @syms.values.include? s.val
                                puts "#{s.location}: error: duplicate value"
                                errors += 1
                            else
                                value = s.val + 1
                            end                        
                        else
                            @syms[s.name] = value
                            value += 1
                        end
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
        def sym(nameOrVal)
            if key.kind_of? String
                @syms[key.to_s]
            else
                @syms.detect{|s|s.val == s.to_i}
            end
        end

        # @private
        def validate(input)
            if sym(input)
               true
            else
                raise
            end
        end

        # @private
        def encode_compact(value, **opts)
            if opts[:opt]
                putPresent + putVLC(value)
            else
                putVLC(value)
            end
        end

    end
end
