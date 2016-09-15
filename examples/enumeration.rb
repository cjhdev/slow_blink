require 'slow_blink'
include SlowBlink

syntax = <<-eos
Singleton = | Lonely

Size = Small | Medium | Large

ExplicitSize = Small/38 | Medium/40 | Large/42

Colour = Red/0xff0000 | Green/0x00ff00 | Blue/0x0000ff

Message ->
    Singleton One,
    Size Two,
    ExplicitSize Three,
    Colour Four    
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

message = model.group("Message").new(
    "One" => "Lonely",
    "Two" => "Small",
    "Three" => "Medium",
    "Four" => "Blue"
)
