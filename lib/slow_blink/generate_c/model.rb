require 'erb'

module SlowBlink

    module GenerateC

        include SlowBlink

        class Model

            def initialize(schema)
                @schema = schema
                @prefix = ""
                @options = {}
            end

            def render
                header = put("groups.h.erb")
                source = put("groups.c.erb")

                File.write("groups.h", header)
                File.write("groups.c", source)
            end            

            private

                def put(filename)
                    ERB.new(File.read(File.expand_path(File.join(File.dirname(__FILE__), filename))), nil, "<>-").result(binding)
                end

                def gname(g)
                    "#{@prefix}#{g.name.gsub("::","_")}"
                end

                def fname(f)
                    "_#{f.name}"
                end

                def value_type(type)

                    out = ""

                    case type.class
                    when BINARY, STRING, FIXED
                        out << "struct blink_string"
                    when U8
                        out << "uint8_t"                
                    when U16
                        out << "uint16_t"                
                    when U32
                        out << "uint32_t"                
                    when U64
                        out << "uint64_t"                
                    when I8
                        out << "int8_t"                
                    when I16
                        out << "int16_t"                
                    when I32
                        out << "int32_t"                
                    when I64
                        out << "int64_t"
                    when ENUM
                        out << "const char *"
                    when FLOATING_POINT
                        out << "double"                
                    when DECIMAL
                        out << "struct blink_decimal"
                    when BOOLEAN
                        out << "bool"                    
                    when StaticGroup
                        out << "struct #{cname(type.name)} *"
                    when OBJECT, DynamicGroup
                        out << "struct base_group *"
                    else
                        raise 
                    end

                    out
                end

        end

    end


end
