require 'slow_blink'
include SlowBlink

# read schema definition from file
schema = Schema.read("your_schema.blink")

# read several schema definitions from file and combine them in that order
schema = Schema.read("common_schema.blink", "specialised_schema.blink")

# read schema definition from memory with optional 'filename' equivalent string
schema = Schema.new(SchemaBuffer.new("Hello/0 -> string greeting", "buffer.blink"))

# read several schema definitions from memory and combine them in that order
schema = Schema.new(SchemaBuffer.new("Hello -> string greeting"), SchemaBuffer.new("Hello <- 0"))

