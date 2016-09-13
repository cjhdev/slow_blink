require 'slow_blink'
include SlowBlink

syntax = <<-eos
Topgroup/0 ->
    string greeting,
    Subgroup * sub
Subgroup/1 ->
    string name,
    u8 number    
eos

# parse schema and generate model
model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

# initialise a message instance
message = model.group "Topgroup", {
    "greeting" => "hello",
    "sub" => model.group("Subgroup", {
        "name" => "my name",
        "number" => 42
    })
}

# encode message instance to compact form
compact_form = message.encode_compact

# decode compact form to a message instance
decoded = model.decode_compact(compact_form)

# read the fields of a message instance
decoded["greeting"]
decoded["sub"]["name"]
decoded["sub"]["number"]
