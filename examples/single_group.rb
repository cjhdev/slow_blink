require 'slow_blink'
include SlowBlink

# create a schema from Blink syntax
buffer = SchemaBuffer.new("Hello/0 -> string greeting")
schema = Schema.new(buffer)

# generate a message model from the schema
model = Message::Model.new(schema)

# create a message instance using the message model
message = model.group("Hello").new("greeting" => "hello")

# same message but by deferred initialisation
equivalent_message = model.group("Hello").new
equivalent_message["greeting"] = "hello"

# convert to compact form...
compact_form = message.encode_compact

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join

# deserialise the string
decoded = model.decode_compact(compact_form)

# read the fields of a message instance
puts decoded["greeting"]

puts decoded.to_tag


