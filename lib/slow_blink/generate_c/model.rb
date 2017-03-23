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
                    f = File.read(File.expand_path(File.join(File.dirname(__FILE__), filename)))
                    erb = ERB.new(f, nil, "<>-")
                    erb.filename = filename
                    erb.result(binding)
                end

                def gname(g)
                    "#{@prefix}#{g.name.gsub("::","_")}"
                end

                def fname(f)
                    "_#{f.name}"
                end

                def fvalue(f)
                    if f.type.sequence?
                        "#{fname(f)}.tail->value"
                    else
                        "#{fname(f)}.value"
                    end
                end

                def testSignature(g, f)
                    "bool #{gname(g)}_test_#{f.name}(group_t group)"
                end

                def clearSignature(g, f)
                    "void #{gname(g)}_clear_#{f.name}(group_t group)"
                end

                def setSignature(g, f)
                    out = "bool #{}_#{gname(g)}_set_#{f.name}(group_t group, "
                    case f.type.class
                    when STRING
                        out << "const char *data, uint32_t len"
                    when BINARY, FIXED
                        out << "const uint8_t *data, uint32_t len"                    
                    when DECIMAL
                        out << "int64_t mantissa, int8_t exponent"
                    when ENUM
                        out << "const char *value"
                    else
                        out << value_type(f.type)
                    end
                    out << ")"
                end

                def getSignature(g, f)
                    out = ""
                    case f.type.class
                    when STRING, BINARY, FIXED, DECIMAL
                        out << "void"
                    when ENUM
                        out << "const char *"
                    else
                        out << value_type(f.type)
                    end
                    out << " #{}_#{gname(g)}_get_#{f.name}(group_t group"
                    case f.type.class
                    when STRING
                        out << ", const char **data, uint32_t len"
                    when BINARY, FIXED
                        out << ", const uint8_t **data, uint32_t len"
                    when DECIMAL
                        out << ", int64_t *mantissa, int8_t *exponent"
                    end
                    out << ")"
                end

                def appendSignature(g,f)
                    setSignature(g,f).sub("_get_","_append_")
                end

                def getResult(f)
                    out = ""
                    case f.type.class
                    when STRING, BINARY, FIXED, DECIMAL
                        out << "void"
                    else
                        out << value_type(f.type)
                    end                    
                end

                def value_type(type)

                    out = ""

                    case type.class
                    when BINARY, STRING, FIXED
                        out << "struct string"
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
                    when I32, ENUM
                        out << "int32_t"                
                    when I64
                        out << "int64_t"
                    when FLOATING_POINT
                        out << "double"                
                    when DECIMAL
                        out << "struct decimal"
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
