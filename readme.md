SlowBlink
==========

[![Build Status](https://travis-ci.org/cjhdev/slow_blink.svg?branch=master)](https://travis-ci.org/cjhdev/slow_blink)
[![Gem Version](https://badge.fury.io/rb/slow_blink.svg)](https://badge.fury.io/rb/slow_blink)

SlowBlink is a Ruby implementation of the [Blink Protocol](http://www.blinkprotocol.org/ "Blink Protocol").

This project is currently under development and not very useful.


## Highlights

- Integrated Blink Protocol schema parser built on GLR Flex/Bison
- VLC encode/decode functions implemented as native extensions
- Message models generated dynamically from Blink schema (no compilation step necessary)
- A complete message serialisation solution dependent only on MRI


## Installation

~~~
gem install slow_blink
~~~

## Examples

### Single Group

~~~ruby
require 'slow_blink'
include SlowBlink

# create a schema from Blink syntax
buffer = SchemaBuffer.new("Hello/0 -> string greeting")
schema = Schema.new(buffer)

# generate a message model from the schema
model = Message::Model.new(schema)

# create a message instance using the message model
message = model.group("Hello").new("greeting" => "hello")

# same message but by deferred initialisation
equivalent_message = model.group("Hello").new
equivalent_message["greeting"] = "hello"

# convert to compact form...
compact_form = message.encode_compact

# deserialise the string
decoded = model.decode_compact(compact_form)

# read the fields of a message instance
puts decoded["greeting"]
~~~

### Static Subgroup

~~~ruby
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
~~~

### Dynamic Subgroup

~~~ruby
require 'slow_blink'
include SlowBlink

syntax = <<-eos
Topgroup/0 ->
    string greeting,
    Subgroup * sub

Subgroup/1 ->
    string name,
    u8 number    
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

message = model.group "Topgroup", {
    "greeting" => "hello",
    "sub" => model.group("Subgroup", {
        "name" => "my name",
        "number" => 42
    })
}

compact_form = message.encode_compact

decoded = model.decode_compact(compact_form)

decoded["greeting"]
decoded["sub"]["name"]
decoded["sub"]["number"]
~~~

### Message Extensions

~~~ruby
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

# append two extensions to "Mail"
message.extension << model.group("Trace").new("Hop" => "local.eg.org")
message.extension << model.group("Trace").new("Hop" => "mail.eg.org")
~~~

## Documentation

- SlowBlink interface documentation can be viewed [online](http://www.rubydoc.info/gems/slow_blink "slow_blink")
- Blink Specification is maintained [here](http://www.blinkprotocol.org/ "Blink Protocol")
- The version of Blink Specification implemented by SlowBlink is included in this repository under `specification/blink`
    
## License

SlowBlink has an MIT license.


## Thanks

Many thanks to the authors of Blink Protocol.


## Contact

Cameron Harper (contact@cjh.id.au)


