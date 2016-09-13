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
 



