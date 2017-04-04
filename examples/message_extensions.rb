require 'slow_blink'
include SlowBlink

syntax = <<-eos
Mail/7 ->
    string Subject,
    string To,
    string From,
    string Body
Trace/8 ->
    string Hop
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

# create base message
message = model.group("Mail").new(        
    "Subject" => "Hello",
    "To" => "you",
    "From" => "me",
    "Body" => "How are you?"
)

# append extensions to "Mail"
message.extension << model.group("Trace").new("Hop" => "local.eg.org")
message.extension << model.group("Trace").new("Hop" => "mail.eg.org")

puts message.encode_compact.bytes.map{ |c| sprintf("\\x%02X",c) }.join

rx = model.decode_compact(message.encode_compact)

puts rx.to_tag
