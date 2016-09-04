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

module SlowBlink::Message

    TYPE_KEY = "$type".freeze

    module StaticGroup

        module CLASS

            def fields
                @fields
            end

            def opt?
                @opt
            end

            def id
                @id
            end

            def name
                @name
            end

            def from_compact!(input)
                if @opt
                    if input.getPresent!
                        fields = {}
                        @fields.each do |f|                    
                            fields[f.name] = f.from_compact!(input)                            
                        end
                        self.new(fields)
                    else
                        self.new(nil)
                    end
                else
                    fields = {}
                    @fields.each do |f|
                        fields[f.name] = f.from_compact!(input)                        
                    end                
                    self.new(fields)
                end            
            end

        end

        module INSTANCE

            def []=(name, value)
                if @value[name]
                    @value[name].set(value)
                else
                    raise "field #{name} is not defined in this group"
                end                    
            end

            def [](name)
                if @value[name]
                    @value[name].get
                else
                    raise "field #{name} is not defined in this group"
                end
            end

            def set(value)            
                if value
                    @value = {}
                    self.class.fields.each do |f|
                        @value[f.name] = value[f.name]
                    end                    
                elsif self.class.opt?                
                    @value = nil
                else
                    raise "this group cannot be NULL"
                end
            end

            def get
                @value
            end

            def initialize(fields)
                if fields
                    set(fields)            
                else
                    @value = {}
                    self.class.fields.each do |f|                        
                        @value[f.name] = f.new(nil)
                    end                
                end                
            end

            def fields
                @value
            end

            def to_compact(out)
                if @value
                    if self.class.opt?
                        out.putPresent
                        self.class.fields.each do |f|
                            @value[f.name].to_compact(out)
                        end
                        out                    
                    else
                        self.class.fields.each do |f|
                            @value[f.name].to_compact(out)
                        end
                        out                                        
                    end
                else
                    out.putPresent(false)
                end
            end

        end

    end

    module DynamicGroup

        module CLASS

            def groups
                @groups
            end

            def permitted
                @permitted
            end

            def opt?
                @opt
            end

            def from_compact!(input)
                buf = input.getBinary!
                if buf.size > 0
                    id = buf.getU64!
                    group = @groups[id]
                    if group
                        if @permitted.include? group.id
                            self.new(group.from_compact!(buf))
                        else
                            raise Error.new "W15: Group is known but unexpected"
                        end
                    else
                        raise Error.new "W2: Group id #{group.id} is unknown"
                    end
                else
                    if self == ModelInstance
                        raise Error.new "W1: Top level group cannot be null"
                    elsif @opt
                        self.new(nil)
                    else
                        raise Error.new "W5: Value cannot be null"
                    end                
                end
            end

        end

        module INSTANCE

            def []=(name, value)
                if @value
                    @value[name] = value
                else
                    raise "undefined dynamic group"
                end
            end

            def [](name)
                if @value
                    @value[name]
                else
                    raise "undefined dynamic group"
                end
            end

            def extension(&group)
                # define extension
                # this is an array of OBJECTs
                # extension do
                #   group "name" do |g|
                #       g["field"] = "value"
                #   end
                #   group "name" do |g|
                #       g["field"] = "value"
                #   end
                #   ...
                # end
                #
                raise                
            end

            def set(value)
                if value
                    if self.class.groups.values.include? value.class
                        if self.class.permitted.include? value.class.id
                            @value = value
                        else
                            raise "group is not a permitted group"
                        end
                    else
                        raise "value is not a group instance"
                    end
                elsif self.class.opt?
                    @value = nil
                else
                    raise
                end        
            end

            def get
                @value
            end

            def initialize(value)
                if value
                    set(value)
                else
                    @value = nil
                end
            end               

            def to_compact(out="")
                if @value
                    group = @value.to_compact("".putU64(@value.class.id))
                    out.putU32(group.size)
                    out << group                    
                else
                    out.putU32(nil)
                end
            end            

        end

    end

end
