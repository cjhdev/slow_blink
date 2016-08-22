require 'slow_blink'
include SlowBlink

input = <<-eos
namespace Whatever

# a group
MyGroup/0 ->
    u8 one,
    u8 two,
    u16 three
eos

schema = Schema.parse(input)

messageData = {
    "$type" => "MyGroup",
    "one" => 1,
    "two" => 2,
    "three" => 333
}

message = Message.new(schema, messageData)

puts message.to_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join





