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

            def generate(prefix)

                `mkdir -p #{prefix}`
                `rm -fr #{File.join(prefix, "*")}`

                header = run_erb("include/groups.h.erb")
                source = run_erb("src/groups.c.erb")

                tc_new = run_erb("test/tc_new.c.erb")
                tc_decodecompact = run_erb("test/tc_decodecompact.c.erb")
                
                testMake = run_erb("test/makefile.erb")
                
                `mkdir #{File.join(prefix, "src")}`
                `mkdir #{File.join(prefix, "include")}`
                `mkdir #{File.join(prefix, "test")}`
                `mkdir #{File.join(prefix, "test", "build")}`
                `mkdir #{File.join(prefix, "test", "bin")}`
                `mkdir #{File.join(prefix, "vendor")}`
                `mkdir #{File.join(prefix, "vendor", "cmocka")}`

                assetsDir = File.expand_path(File.join(File.dirname(__FILE__), "../../../assets"))

                `cp #{assetsDir}/ublink/src/blink_stream.c #{prefix}/src`
                `cp #{assetsDir}/ublink/src/blink_compact.c #{prefix}/src`
                
                `cp #{assetsDir}/ublink/include/blink_stream.h #{prefix}/include`
                `cp #{assetsDir}/ublink/include/blink_compact.h #{prefix}/include`

                `cp #{assetsDir}/ublink/include/blink_debug.h #{prefix}/include`

                `cp -r #{assetsDir}/cmocka/src #{prefix}/vendor/cmocka/`
                `cp -r #{assetsDir}/cmocka/include #{prefix}/vendor/cmocka/`
                `cp #{assetsDir}/cmocka/COPYING #{prefix}/vendor/cmocka/`
                

                File.open("#{prefix}/include/groups.h", "w"){|f|f.write(header)}
                File.open("#{prefix}/src/groups.c", "w"){|f|f.write(source)}

                File.open("#{prefix}/test/tc_new.c", "w"){|f|f.write(tc_new)}
                File.open("#{prefix}/test/tc_decodecompact.c", "w"){|f|f.write(tc_decodecompact)}
                
                File.open("#{prefix}/test/makefile", "w"){|f|f.write(testMake)}

                puts `cd #{prefix}/test && make`

            end

            private

                def run_erb(filename)
                    f = File.read(File.expand_path(File.join(File.dirname(__FILE__), filename)))
                    erb = ERB.new(f, nil, "<>-")
                    erb.filename = filename
                    erb.result(binding)
                end

                def gname(g)
                    "#{@prefix}#{g.name.gsub(":","_")}"
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
                        out << "#{value_type(f.type)} value"
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
                    out << " #{gname(g)}_get_#{f.name}(group_t group"
                    case f.type.class
                    when STRING
                        out << ", const char **data, uint32_t *len"
                    when BINARY, FIXED
                        out << ", const uint8_t **data, uint32_t *len"
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
