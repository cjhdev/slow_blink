module SlowBlink

    class Log

        @file = STDERR
    
        def self.file=(file)
            @file = file
        end

        def self.file
            @file
        end

        def self.error(msg)
            if @file
                @file.puts(msg)
            end
        end

        def self.info(msg)
            if @file
                @file.puts(msg)
            end
        end
    
    end

end
