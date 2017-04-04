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

schema = Schema.new(syntax)
model = Message::Model.new(schema)

message = model.group("MyMessage").new(
    "Header" => model.group("StandardHeader").new("SeqNo" => 1,
        "SendingTime" => "2012-10-30 00:00:00 GMT+1"),
    "Text" => "my name"
)

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join
rx = model.decode_compact(message.encode_compact)

puts rx["Header"]["SeqNo"]
puts rx["Header"]["SendingTime"]
puts rx["Text"]

puts rx.to_tag

# or

message = model.group("MyMessage").new(
    "Header" => {"SeqNo" => 1,
        "SendingTime" => "2012-10-30 00:00:00 GMT+1"},
    "Text" => "my name"
)

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join
rx = model.decode_compact(message.encode_compact)

puts rx["Header"]["SeqNo"]
puts rx["Header"]["SendingTime"]
puts rx["Text"]

puts rx.to_tag
