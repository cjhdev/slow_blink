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

message = model.group("Mail",    
    {
        "Subject" => "Hello",
        "To" => "you",
        "From" => "me",
        "Body" => "How are you?"    
    },
    model.group("Trace", {
        "Hop" => "local.eg.org"
    }),
    model.group("Trace", {
        "Hop" => "mail.eg.org"
    })
)

compact_form = message.encode_compact
decoded = model.decode_compact(compact_form)

decoded["Subject"]
decoded["To"]
decoded["From"]
decoded["Body"]
decoded.extension[0]["Hop"]
decoded.extension[1]["Hop"]
