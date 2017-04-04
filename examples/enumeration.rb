require 'slow_blink'
include SlowBlink

syntax = <<-eos
Singleton = | Lonely

Size = Small | Medium | Large

ExplicitSize = Small/38 | Medium/40 | Large/42

Colour = Red/0xff0000 | Green/0x00ff00 | Blue/0x0000ff

Message/0 ->
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

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join

rx = model.decode_compact(message.encode_compact)

puts rx["One"]
puts rx["Two"]
puts rx["Three"]
puts rx["Four"]

puts rx.to_tag
