require 'slow_blink'

# create a schema from Blink syntax
buffer = SlowBlink::SchemaBuffer.new("Hello/0 -> string greeting")
schema = SlowBlink::Schema.new(buffer)

# generate a message model from the schema
model = SlowBlink::Message::Model.new(schema)

# create a message instance using the message model
message = model.group "Hello", {"greeting" => "hello"}    

# serialise the message instance
compact_form = message.encode_compact

# deserialise the string
decoded = model.decode_compact(compact_form)

# read the fields of a message instance
decoded["greeting"]
