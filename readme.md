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

### Create a Schema From Schema Definitions

~~~ruby
require 'slow_blink'
include SlowBlink

# read schema definition from file
schema = Schema.read("your_schema.blink")

# read several schema definitions from file and combine them in that order
schema = Schema.read("common_schema.blink", "specialised_schema.blink")

# read schema definition from memory with optional 'filename' equivalent string
schema = Schema.new(SchemaBuffer.new("Hello/0 -> string greeting", "buffer"))

# read several schema definitions from memory and combine them in that order
schema = Schema.new(SchemaBuffer.new("Hello -> string greeting"), SchemaBuffer.new("Hello <- 0"))
~~~

### Single Group

~~~ruby
require 'slow_blink'
include SlowBlink

schema = Schema.new(SchemaBuffer.new("Hello/0 -> string greeting"))

# generate a message model from the schema
model = Message::Model.new(schema)

# create a message instance using the message model
message = model.group("Hello").new("greeting" => "hello")

# same message but by deferred initialisation
equivalent_message = model.group("Hello").new
equivalent_message["greeting"] = "hello"

# convert to compact form...
compact_form = message.encode_compact

# convert from compact form...
decoded = model.decode_compact(compact_form)

# read the field values of a message instance
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
~~~

### Dynamic Subgroup

~~~ruby
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

message = model.group("Mail").new(        
    "Subject" => "Hello",
    "To" => "you",
    "From" => "me",
    "Body" => "How are you?"
)

# append two extensions to message
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


