require 'slow_blink'
include SlowBlink

syntax = <<-eos
Shape ->
    decimal Area

Rect/3 : Shape ->
    u32 Width,
    u32 Height

Circle/4 : Shape ->
    u32 Radius

Canvas/5 ->
    Shape * [] Shapes    
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

message = model.group("Canvas").new(
    "Shapes" => [
        model.group("Rect").new("Area" => 6.0, "Width" => 2, "Height" => 3),
        model.group("Circle").new("Area" => 28.3, "Radius" => 3)
    ]
)

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join
 
rx = model.decode_compact(message.encode_compact)
