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
    class Definition

        include Annotatable

        def self.===(other)
            self == other                
        end

        # @return [String]
        attr_reader :location

        # @return [String]
        attr_reader :nameWithID

        # @return [ENUMERATION]
        # @return [Type]
        attr_reader :type

        # @param namespace [Namespace]
        def namespace=(namespace)
            @ns = namespace
        end

        # @private
        #
        # @param nameWithID [NameWithID]
        # @param type [ENUMERATION, Type]
        # @param location [String]
        def initialize(nameWithID, type, location)
            @annotes = {}
            @type = type
            @location = location
            @nameWithID = nameWithID
            @ns = nil
        end

        # Resolve references, enforce constraints, and detect cycles
        #
        # @param schema [Schema] schema this definition belongs to
        # @param stack [nil, Array] objects that depend on this object
        # @param [true,false] linked?
        def link(schema, stack=[])
                     
            # a definition can resolve to a definition only if there is a dynamic
            # link somewhere in the chain
            sf = stack.each
            begin
                loop do
                    if sf.next == self
                        loop do
                            begin
                                f = sf.next
                                if f.respond_to? "dynamic?".to_sym and f.dynamic?
                                    return schema
                                end
                            rescue StopIteration
                                raise Error.new "#{self.location}: error: invalid cycle detected"
                            end                                   
                        end
                    end
                end
            rescue StopIteration
            end

            @type.link(schema, @ns, stack << self)
            
        end

    end
end
