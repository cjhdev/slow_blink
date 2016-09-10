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

# create a schema from Blink syntax
buffer = SlowBlink::SchemaBuffer.new("Hello/0 -> string greeting")
schema = SlowBlink::Schema.new(buffer)

# generate a message model from the schema
model = SlowBlink::Message::Model.new(schema)

# create a message instance using the message model
message = model.group "Hello", {"greeting" => "hello"}    

# serialise the message instance
compact_form = message.encode_compact

# deserialise the string
decoded = model.decode_compact(compact_form)

# read the fields of a message instance
decoded["greeting"]
~~~

### Static Subgroup

~~~ruby
require 'slow_blink'
include SlowBlink

syntax = <<-eos
Topgroup/0 ->
    string greeting,
    Subgroup sub

Subgroup ->
    string name,
    u8 number
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

message = model.group "Topgroup", {
    "greeting" => "hello",
    "sub" => {
        "name" => "my name",
        "number" => 42
    }
}

compact_form = message.encode_compact

decoded = model.decode_compact(compact_form)

decoded["greeting"]
decoded["sub"]["name"]
decoded["sub"]["number"]
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


