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

    class TestData

        # generate test data for a particular model
        def initialize(model)
            @model = model
        end

        # create an instance of group (name) and initialise
        # the fields
        def set(name)
            group = @model.group(name).new
            @model.schema.groups.detect{|g|g.name == name}.fields.each do |f|
                data = fieldData(f)
                if f.type.sequence? and data
                    group[f.name] = [data]
                else
                    group[f.name] = data
                end                
            end
            group
        end

        # return a random valid test value for a given field type
        #
        # 
        def fieldData(field, **opts)

            if !field.is_a? SlowBlink::Field
                ArgumentError.new "field argument must be an instance of SlowBlink::Field"
            end

            case field.type.class
            when SlowBlink::FIXED
                s = (0...field.type.size).map { (65 + rand(26)).chr }.join
                if field.optional?
                    [s, nil].sample
                else
                    s
                end                
            when SlowBlink::BINARY, SlowBlink::STRING
                if field.type.size
                    s = (0...rand(field.type.size)).map { (65 + rand(26)).chr }.join
                else
                    s = (0...rand(50)).map { (65 + rand(26)).chr }.join
                end
                if field.optional?
                    [s, nil].sample
                else
                    s
                end                
            when SlowBlink::BOOLEAN
                if field.optional?
                    [true, false, nil].sample
                else
                    [true, false].sample
                end
            when SlowBlink::U8, SlowBlink::U16, SlowBlink::U32, SlowBlink::U64, SlowBlink::I8, SlowBlink::I16, SlowBlink::I32, SlowBlink::I64
                if field.optional?
                    [rand(field.type.class::RANGE), nil].sample
                else
                    rand(field.type.class::RANGE)
                end
            when SlowBlink::FLOATING_POINT, SlowBlink::DECIMAL
                if field.optional?
                    [rand(Float::MIN, Float::MAX), nil].sample
                else
                    rand(Float::MIN, Float::MAX)
                end            
            when SlowBlink::ENUM
                if field.optional?
                    field.type.symbols.map{|s|s.name}.push(nil).sample
                else
                    field.type.symbols.sample.name
                end
            when SlowBlink::MILLI_TIME, SlowBlink::NANO_TIME, SlowBlink::DATE
                if field.optional?
                    [0, nil].sample
                else
                    0
                end
            when SlowBlink::TIME_OF_DAY_MILLI, SlowBlink::TIME_OF_DAY_NANO
                if field.optional?
                    [0, nil].sample
                else
                    0
                end
            when SlowBlink::StaticGroup, SlowBlink::DynamicGroup

                if field.optional?
                    [set(field.type.name), nil].sample
                else
                    set(field.type.name)
                end
    
            else
                raise "no support for #{field.type}"
            end
                
        end

        private

            def time_rand(from=0.0, to=Time.now)
                Time.at(from + rand * (to.to_f - from.to_f))
            end

    end


end
