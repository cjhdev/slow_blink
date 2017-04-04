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

module SlowBlink::Message

    class DynamicGroup

        def self.taggedGroups
            @taggedGroups
        end

        def self.permittedID
            @permittedID
        end

        def self.from_compact(input, depth)

            group = nil

            if depth > 0
                depth = depth - 1
            else
                raise RecursionLimit
            end

            if input.kind_of? String
                input = StringIO.new(input)
            end

            buf = input.getBinary

            if buf.nil?

                group = nil

            elsif buf.size == 0

                raise WeakError5.new "W5: Value cannot be null"                
        
            else

                buf = StringIO.new(buf)
                id = buf.getU64

                if klass = @taggedGroups[id]

                    if @permittedID.include? id

                        group = klass.from_compact(buf, depth)

                        if !buf.eof?                
                            size = buf.getU32
                            while group.extension.size < size do
                                group.extension << @anyTaggedGroup.from_compact(buf, depth).get
                            end
                        end

                        if !buf.eof?
                            raise ExtensionPadding
                        end
                        
                    else
                        raise WeakError15.new "W15: Group is known but unexpected"
                    end
                else
                    raise WeakError2.new "W2: Group id #{id} is unknown"
                end                   
                
            end

            depth = depth + 1
            self.new(group)

        end

        def set(value)
            if value.kind_of? Group
                if self.class.permittedID.include? value.class.id        
                    @value = value
                else                        
                    raise TypeError.new "incompatible group"
                end
            else
                raise ArgumentError.new "argument must be kind_of Group"
            end
        end

        # @return [Group] contained group
        def get
            @value.get
        end

        # @note calls {#set}(value)
        def initialize(value)
            set(value)
        end

        # @private
        def to_compact(out)
            @value.encode_compact(out)        
        end

        def extension
            @value.extension
        end

        def to_tag
            "@#{@value.class.name}#{@value.to_tag_value}#{@value.to_tag_extension}"                    
        end

    end

end

