require 'erb'

module SlowBlink

    module GenerateC

        include SlowBlink

        class Model

            def initialize(schema)
                @schema = schema
                @prefix = "__"                
            end

            def render
                File.write("groups.h", ERB.new(File.read(File.expand_path(File.join(File.dirname(__FILE__), "groups.h.erb"))), nil, "<>-").result(binding))
                File.write("groups.c", ERB.new(File.read(File.expand_path(File.join(File.dirname(__FILE__), "groups.c.erb"))), nil, "<>-").result(binding))
            end
            def render_source
                filename = File.expand_path(File.join(File.dirname(__FILE__), "groups.c.erb"))
                header = File.read(filename)
                File.write("groups.c", ERB.new(header).result(binding))
            end

            def cname(name)
                "#{@prefix}#{name.gsub("::","_")}"
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

=begin

            def putGroupEnum

                out = StringIO.new

                out.puts "enum group_type {"
    
                @schema.groups.each do |g|

                    out.puts "    TYPE_#{g.name},"        

                end

                out.puts "};"

                out.string

            end

            def putGroupStructs
        
                out = StringIO.new

                @schema.groups.each do |g|

                    out.puts "struct #{g.name} {"
                    out.puts "    struct group_base super;"
                    out.puts "    uint32_t size;"

                    g.fields.each do |f|

                        out.puts "    bool initialised;"

                        case g.type
                        when STRING, BINARY 

                            if g.type.is_a? FIXED or f.type.size
                                out.puts "    struct {"
                                out.puts "        uint8_t value[#{f.type.size}];"
                                out.puts "        uint32_t len;"
                                out.puts "    } value;"
                            else
                                out.puts "    struct {"
                                out.puts "        uint8_t *value;"
                                out.puts "        uint32_t len;"
                                out.puts "        uint32_t max;"
                                out.puts "    } value;"
                            end

                        when DECIMAL

                            out.puts "    struct blink_decimal value;"

                        else

                            out.puts "    #{getValueType(f.type)} value;"

                        end

                    end

                    if f.sequence?

                    else

                        out.puts "    bool (*set_#{f.name})(struct #{g.name} *self, #{getValueType(f.type)} value);"
                        out.puts "    bool (*get_#{f.name})(struct #{g.name} *self, #{getValueType(f.type)} *value);"
                        out.puts "    bool (*#{f.name}_isPresent)(struct #{g.name} *self);"
    
                    end

                    out.puts "    bool (*encodeCompact)(struct #{g.name} *self, blink_stream_t out);"

                    out.puts "};"
                end                   

                out.string

            end

            def putGroupFunctions

                out = StringIO.new

                @schema.groups.each do |groupName, g|

                    out.puts putFieldAccessors(g)
                    out.puts putGroupSizeof(g)
                    out.puts putGroupEncodeCompact(g)
                    out.puts putGroupDestroy(g)
                    out.puts putGroupNew(g)
                    
                end

                out.string

            end

            def putFieldAccessors(g)

                out = StringIO.new

                g.fields.each do |fieldName, f|

                    if f.sequence?

                    else

                        putFieldGetter(g, f)
                        putFieldSetter(g, f)

                        out.puts "static bool #{g.name}_#{f.name}_isPresent(struct #{g.name} self)"
                        out.puts "{"
                        out.puts "    return self->#{f.name}.initialised;"
                        out.puts "}"

                    end

                end

                out.string
                
            end

            def putFieldGetter(g, f)

                out = StringIO.new
                
                out.puts "static #{getValueType(f.type)} #{g.name}_get_#{f.name}(struct #{g.name} *self)"
                out.puts "{"
                out.puts "    return self->#{f.name}.value;"
                out.puts "}"

                out.string
                
            end

            def putFieldSetter(g, f)

                out = StringIO.new

                out.puts "static bool #{g.name}_set_#{f.name}(struct #{g.name} self, #{getValueType(f.type)} value)"
                out.puts "{"
                out.puts "    bool retval = false;"
            
                case f.type
                when STRING, BINARY, FIXED

                    if t.type.is_a? FIXED or f.size

                        out.puts "    if(sizeof(self->#{f.name}.value.data) >= value.size){"
                        out.puts "        (void)memcpy(self->#{f.name}.value.data, value.data, value.size);"
                        out.puts "        retval = true;"
                        out.puts "    }"
                        out.puts "    else{"
                        out.puts "        BLINK_ERROR(\"value is larger than field capacity\")"
                        out.puts "    }"

                    else

                        out.puts "    if((self->#{f.name}.value.data != NULL) && (self->super.a.free != NULL)){"
                        out.puts "        self->super.a.free(self->#{f.name}.value.data);"
                        out.puts "        self->#{f.name}.value.data = NULL;"                        
                        out.puts "        self->#{f.name}.value.len = 0U;"                        
                        out.puts "    }"
                        out.puts "    self->#{f.name}.value.data = self->super.alloc.calloc(value.size, 1U)"
                        out.puts "    if(self->#{f.name}.value.data != NULL){"
                        out.puts "        self->#{f.name}.value.len = value.size;"
                        out.puts "        (void)memcpy(self->#{f.name}.value.data, value.data, value.size);"
                        out.puts "        retval = true;"
                        out.puts "    }"
                        out.puts "    else{"
                        out.puts "        BLINK_ERROR(\"calloc()\")"
                        out.puts "    }"
                        
                    end

                when DECIMAL

                    out.puts "    self->#{f.name}.value.mantissa = value.mantissa;"
                    out.puts "    self->#{f.name}.value.exponent = value.exponent;"

                else

                    out.puts "    self->#{f.name}.value = value;"

                end 
                
                out.puts "    self->#{f.name}.initialised = retval;"
                out.puts "    return retval;"
                out.puts "}"

                out.string

            end

            def putGroupNew(g)

                out = StringIO.new
                
                out.puts "struct #{g.name} *New_#{g.name}(struct blink_allocator alloc)"
                out.puts "{"
                out.puts "    struct #{g.name} *retval = NULL;"
                out.puts "    if(alloc.calloc != NULL){"
                out.puts "        retval = alloc.calloc(sizeof(struct #{g.name}), 1U);"
                out.puts "        if(retval != NULL){"                
                out.puts "            retval->super.type = TYPE_#{g.name};"
                out.puts "            retval->super.a = alloc;"

                g.fields.each do |fieldName, f|

                    if f.sequence?

                    else

                        out.puts "            group->get_#{f.name} = #{g.name}_get_#{f.name};"
                        out.puts "            group->set_#{f.name} = #{g.name}_set_#{f.name};"
                        out.puts "            group->#{f.name}_isPresent = #{g.name}_#{f.name}_isPresent;"

                    end

                end

                if g.id    
                    out.puts "                out->encodeCompact = #{g.name}_encodeCompact;"
                end

                out.puts "                out->sizeof = #{g.name}_sizeof;"
                
                out.puts "        }"
                out.puts "        else{"
                out.puts "            BLINK_ERROR(\"calloc()\")"
                out.puts "        }"
                out.puts "    }"
                out.puts "    else{"
                out.puts "        BLINK_ERROR(\"cannot create a new group without an allocator\")"
                out.puts "    }"
                out.puts "    return retval;"
                out.puts "}"

                out.string

            end

            
            def putGroupDestroy(g)
            end

            def putGroupEncodeCompact(g)

                out = StringIO.new
                out.puts "static bool #{g.name}_encodeCompact(struct #{g.name} *self, blink_stream_t out)"
                out.puts "{"                
                out.puts "    bool retval = false;"                
                out.puts "    uint32_t size;"                
                out.puts "    if(#{g.name}_sizeof(self, &size)){"
                out.puts "        do{"
                out.puts "            if(!BLINK_Compact_encodeU32(out, size)){"
                out.puts "                break;"
                out.puts "            }"
                out.puts "            if(!BLINK_Compact_encodeU64(out, #{g.id})){"
                out.puts "                break;"
                out.puts "            }"
                    
                f.fields.each do |fieldName, f|
                
                    out.puts "            if(f->#{f.name}.initialised){"

                    case f.type
                    when STRING, BINARY
                        out.puts "                if(!BLINK_Compact_encodeU32(out, f->#{f.name}.value.size){"
                        out.puts "                    break;"
                        out.puts "                }"
                        out.puts "                if(!BLINK_Stream_write(out, f->#{f.name}.value.data, f->#{f.name}.value.size)){"
                        out.puts "                    break;"
                        out.puts "                }"
                    when FIXED
                        if f.optional?
                             out.puts "               if(!BLINK_Compact_encodePresent(out)){"
                             out.puts "                   break;"
                             out.puts "               }"
                        end
                        out.puts "                if(!BLINK_Stream_write(out, f->#{f.name}.value.data, f->#{f.name}.value.size)){"
                        out.puts "                    break;"
                        out.puts "                }"
                    when DECIMAL
                        out.puts "                if(!BLINK_Compact_encodeI8(out, self->#{f.name}.value.exponent)){"
                        out.puts "                    break;"
                        out.puts "                }"
                        out.puts "                if(!BLINK_Compact_encodeI64(out, self->#{f.name}.value.mantissa)){"
                        out.puts "                    break;"
                        out.puts "                }"
                    when BOOLEAN
                        out.puts "                if(!BLINK_Compact_encodeBool(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when I8
                        out.puts "                if(!BLINK_Compact_encodeI8(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when I16
                        out.puts "                if(!BLINK_Compact_encodeI16(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when I32, DATE, ENUM
                        out.puts "                if(!BLINK_Compact_encodeI32(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when I64, NANO_TIME, MILLI_TIME
                        out.puts "                if(!BLINK_Compact_encodeI64(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when U8
                        out.puts "                if(!BLINK_Compact_encodeU8(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when U16
                        out.puts "                if(!BLINK_Compact_encodeU16(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when U32, TIME_OF_DAY_MILLI
                        out.puts "                if(!BLINK_Compact_encodeU32(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when U64, TIME_OF_DAY_NANO
                        out.puts "                if(!BLINK_Compact_encodeU64(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when FLOATING_POINT
                        out.puts "                if(!BLINK_Compact_encodeF64(out, self->#{f.name}.value)){"
                        out.puts "                    break;"
                        out.puts "                }"                        
                    when StaticGroup
                    when DynamicGroup
                    else
                        raise
                    end

                    out.puts "            }"
                    out.puts "            else{"
                    out.puts "                if(!BLINK_Compact_encodeNull(out)){"
                    out.puts "                    break;"                    
                    out.puts "                }"                    
                    out.puts "            }"                    

                end

                out.puts "            retval = true;"                    
                out.puts "        }while(false);"                
                out.puts "    }"
                out.puts "    return retval;"
                out.puts "}"
                out.string
            
            end

            def putGroupSizeof(g)

                out = StringIO.new
                out.puts "static bool #{g.name}_sizeof(struct #{g.name} *self, uint32_t *size)"
                out.puts "{"
                out.puts "    bool retval = true;"
                out.puts "    uint32_t size = BLINK_Compact_sizeofUnsigned(#{g.id});"

                g.fields.each do |fieldName, f|

                    out.puts "    if(self->#{f.name}.initialised){"

                    out.puts "        size = 0U;"

                    case f.type
                    when STRING, BINARY

                        out.puts "        size += BLINK_Compact_sizeofUnsigned(self->#{f.name}.value.size);"
                        out.puts "        size += self->#{f.name}.value.size;"

                    when FIXED

                        if f.optional?
                            out.puts "        size += 1U;"
                        end
                        out.puts "        size += self->#{f.name}.value.size;"

                    when I8, I16, I32, I64, TIME_OF_DAY_MILLI, TIME_OF_DAY_NANO
                    
                        out.puts "        size += BLINK_Compact_sizeofSigned((int64_t)self->#{f.name}.value);"
                        
                    when U8, U16, U32, U64, MILLI_TIME, NANO_TIME
                    
                        out.puts "        size += BLINK_Compact_sizeofUnsigned((uint64_t)self->#{f.name}.value);"
                    end

                    out.puts "    }"
                    out.puts "    else{"

                    if f.optional?

                        out.puts "        size += 1U;"

                    else

                        out.puts "BLINK_ERROR(\"#{f.name} must be initialised\")"
                        out.puts "return false;"

                    end
                    
                    out.puts "    }"
                    
                end

                out.puts "    return retval;"
                out.puts "}"
                out.string
        
            end
    
            

=end

        end

    end


end
