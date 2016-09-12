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

# or, by deferred initialisation
deferred_init = model.group("MyMessage").new
deferred_init["Header"] = model.group("StandardHeader").new
deferred_init["Header"]["SeqNo"] = 1
deferred_init["Header"]["SendingTime"] = "2012-10-30 00:00:00 GMT+1"
deferred_init["Text"] = "my name"

# or, by mixed deferred initialisation
mixed_deferred_init = model.group("MyMessage").new
mixed_deferred_init["Header"] = {
    "SeqNo" => 1,
    "SendingTime" => "2012-10-30 00:00:00 GMT+1"
}
mixed_deferred_init["Text"] = "my name"
