require 'slow_blink'
include SlowBlink

syntax = <<-eos
StandardHeader ->
    u64 SeqNo,
    millitime SendingTime
MyMessage/2 ->
    StandardHeader Header,
    string Text
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

message = model.group("MyMessage").new(
    "Header" => {
        "SeqNo" => 1,
        "SendingTime" => "2012-10-30 00:00:00 GMT+1"
    },
    "Text" => "my name"
)

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join
