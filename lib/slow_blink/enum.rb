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

    class ENUM < Type

        def self.===(other)
            self == other                
        end

        # @return [Array<Sym>]
        def symbols
            @symbols.values
        end

        # @return [String]
        attr_reader :name

        # @private
        def initialize(attr)

            @location = attr[:loc]
            @symbols = {}
            @name = attr[:name].dup.freeze

            attr[:syms].each do |s|

                if @symbols[s[:name]]
                    raise ParseError.new "#{s[:loc]}: duplicate symbol name"
                else
                    if s[:value]
                        if s[:value] < 2147483647 and s[:value] > -2147483648                            
                            if @symbols.values.last
                                if @symbols.values.map{|sym|sym.value}.include? s[:value]
                                    raise ParseError.new "#{s[:loc]}: ambiguous enum value"
                                else
                                    @symbols[s[:name]] = Sym.new(s)                    
                                end
                            else
                                @symbols[s[:name]] = Sym.new(s)
                            end
                        else
                            raise ParseError.new "#{s[:loc]}: value out of range for an enum"
                        end                        
                    else
                        if @symbols.values.last
                            if (@symbols.values.last.value + 1) < 2147483647
                                if @symbols.values.map{|sym|sym.value}.include? s[:value]
                                    raise ParseError.new "#{s[:loc]}: ambiguous enum value"
                                else
                                    @symbols[s[:name]] = Sym.new(s.merge({:implicit => true, :value => @symbols.values.last.value + 1}))
                                end                                
                            else
                                raise ParseError.new "#{s[:loc]}: implicit value out of range for an enum"
                            end
                        else
                            @symbols[s[:name]] = Sym.new(s.merge({:implicit => true, :value => 0}))
                        end
                    end
                end

            end        
            
        end

        # @param nameOrVal [String,Integer]
        # @raise [RangeError] nameOrVal does not resolve to a symbol
        # @return [Sym]
        def symbol(nameOrVal)
            if nameOrVal.kind_of? String
                if (result = @symbols[nameOrVal]).nil?
                    raise RangeError
                end
            else
                if (result = @symbols.values.detect{|s|s.value == nameOrVal.to_i}).nil?
                    raise RangeError
                end
            end
        end

    end
end
