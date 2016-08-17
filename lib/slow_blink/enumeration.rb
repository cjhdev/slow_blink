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
        attr_reader :symbols

        # @param syms [Array<Sym>] symbol list
        def initialize(syms)
            @syms = syms
            @list = {}            
        end

        # @macro common_to_s
        def to_s
            if @syms.size == 1
                "| #{@syms.first}"
            else
                @syms.inject("") do |acc,s|
                    if s != @syms.first
                        acc << " | "
                    end
                    acc << s.to_s
                end
            end
        end

        # @macro common_link
        def link(schema, stack=[])
            if @schema != schema
                value = 0
                @list = {}        
                @schema = nil
                @syms.each do |s|
                    if @list[s.name]
                        puts "duplicate name"
                        return nil
                    else
                        if s.val
                            if @list.values.include? s.val
                                puts "duplicate value"
                                return nil
                            else
                                value = s.val + 1
                            end                        
                        else
                            @list[s.name] = value
                            value += 1
                        end
                    end
                end
                @schema = schema
            end
            @schema            
        end

    end
end
