module SlowBlink

    module MessageTest

        include SlowBlink

        # return a random valid test value for a given field
        def self.testField(f, **opts)

            case f.type.class
            when FIXED
                s = (0...f.type.size).map { (65 + rand(26)).chr }.join
                if f.optional?
                    [s, nil].sample
                else
                    s
                end                
            when BINARY, STRING
                if f.type.size
                    s = (0...rand(f.type.size)).map { (65 + rand(26)).chr }.join
                else
                    s = (0...rand(50)).map { (65 + rand(26)).chr }.join
                end
                if f.optional?
                    [s, nil].sample
                else
                    s
                end                
            when BOOLEAN
                if f.optional?
                    [true, false, nil].sample
                else
                    [true, false].sample
                end
            when U8, U16, U32, U64, I8, I16, I32, I64
                if f.optional?
                    [rand(f.type.class::RANGE), nil].sample
                else
                    rand(f.type.class::RANGE)
                end
            when FLOATING_POINT, DECIMAL
                if f.optional?
                    [rand(Float::MIN, Float::MAX), nil].sample
                else
                    rand(Float::MIN, Float::MAX)
                end            
            when ENUM
                if f.optional?
                    f.type.symbols.map{|s|s.name}.push(nil).sample
                else
                    f.type.symbols.sample.name
                end
            when MILLI_TIME, NANO_TIME, Date
            when TIME_OF_DAY_MILLI, TIME_OF_DAY_NANO

            when StaticGroup
            when DynamicGroup
            
            else
                raise "no support for #{f.type}"
            end
                
        end

    end

end
