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

    class ENUMERATION

        include Annotatable

        def self.===(other)
            self == other                
        end

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
        # Resolve references, enforce constraints, and detect cycles
        #
        # @param schema [Schema] schema this definition belongs to
        # @param namespace [Namespace] namespace this definition belongs to
        # @param stack [nil, Array] objects that depend on this object
        # @param [true,false] linked?
        def link(schema, ns, stack=[])
            if @schema.nil?
                value = 0
                @syms = {}
                @schema = schema
                @rawSyms.each do |s|
                    if @syms[s.name]
                        Log.error "#{s.location}: error: symbols within an enumeration must have unique names ('#{s.name}' first appears at #{@syms[s.name].location})"
                        @schema = nil
                    else
                        if s.val
                            if @syms.values.include? s.val
                                Log.error "#{s.location}: error: values of symbols must be distinct ('#{s.val}' first appears at #{@syms[s.val].location})"
                                @schema = nil
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
                @syms.values.detect{|s|s.val == nameOrVal.to_i}
            end
        end

    end
end
