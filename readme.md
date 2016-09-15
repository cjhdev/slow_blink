SlowBlink
==========

[![Build Status](https://travis-ci.org/cjhdev/slow_blink.svg?branch=master)](https://travis-ci.org/cjhdev/slow_blink)
[![Gem Version](https://badge.fury.io/rb/slow_blink.svg)](https://badge.fury.io/rb/slow_blink)

SlowBlink is a Ruby implementation of [Blink Protocol](http://www.blinkprotocol.org/ "Blink Protocol").

SlowBlink was written to evaluate Blink Protocol. It is not suitable for production at this time.

## Highlights

- Integrated Blink Protocol schema parser (GLR Flex/Bison)
- Dynamic message model generator
    - Does not generate constants or symbols
- Low level encode/decode functions implemented as native extensions
- Implements Blink Specification [beta4-2013-06-14](specification/blink/BlinkSpec-beta4.pdf "Blink Specification").

## Installation

~~~
gem install slow_blink
~~~

## Examples

### Create a Schema From Schema Definition(s)

~~~ruby
require 'slow_blink'
include SlowBlink

# read schema definition from file
schema = Schema.read("your_schema.blink")

# read several schema definitions from file and combine them in order read
schema = Schema.read("common_schema.blink", "specialised_schema.blink")

# read schema definition from memory with optional 'filename' equivalent string
schema = Schema.new(SchemaBuffer.new("Hello/0 -> string greeting", "buffer.blink"))

# read several schema definitions from memory and combine them in order read
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

# "\x07\x00\x05\x68\x65\x6C\x6C\x6F"
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

# "\x39\x07\x05\x48\x65\x6C\x6C\x6F\x03\x79\x6F\x75\x02\x6D\x65\x0C\x48\x6F\x77\x20\x61\x72\x65\x20\x79\x6F\x75\x3F\x02\x0E\x08\x0C\x6C\x6F\x63\x61\x6C\x2E\x65\x67\x2E\x6F\x72\x67\x0D\x08\x0B\x6D\x61\x69\x6C\x2E\x65\x67\x2E\x6F\x72\x67"
message.encode_compact

~~~

### Enumeration

~~~ruby
require 'slow_blink'
include SlowBlink

syntax = <<-eos
Singleton = | Lonely

Size = Small | Medium | Large

ExplicitSize = Small/38 | Medium/40 | Large/42

Colour = Red/0xff0000 | Green/0x00ff00 | Blue/0x0000ff

Message/0 ->
    Singleton One,
    Size Two,
    ExplicitSize Three,
    Colour Four    
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(syntax)))

message = model.group("Message").new(
    "One" => "Lonely",
    "Two" => "Small",
    "Three" => "Medium",
    "Four" => "Blue"
)

# "\x06\x00\x00\x00\x28\xBF\x03"
message.encode_compact

~~~

## Documentation

- SlowBlink interface documentation can be viewed [online](http://www.rubydoc.info/gems/slow_blink "slow_blink")
- Blink Specification is maintained [here](http://www.blinkprotocol.org/ "Blink Protocol")
- The version of Blink Specification implemented by SlowBlink is included in this repository under `specification/blink`

## Typical Performance

~~~
schema with data:

    InsertOrder/1 ->
        string Symbol,  # set to "IBM"
        string OrderId, # set to "ABC123"
        u32 Price,      # set to 125
        u32 Quantity    # set to 1000

compact form:

    \x0F\x01\x03\x49\x42\x4D\x06\x41\x42\x43\x31\x32\x33\x7D\xA8\x0F  (16 bytes)

benchmark:
                                                         user     system      total        real
100000 x Schema.new                                  3.630000   0.550000   4.180000 (  4.176857)
100000 x Message::Model.new                          3.870000   0.000000   3.870000 (  3.873298)
100000 x Message::Model#group.new#encode_compact     1.300000   0.000000   1.300000 (  1.295605)
100000 x Message::Model#decode_compact               1.360000   0.000000   1.360000 (  1.362102)

parse                 23941 schema/s
generate              25817 model/s
initialise and encode 77184 message/s    (1234944 Bytes/s)
decode                73415 message/s    (1174640 Bytes/s)

running ruby 2.2.1p85 (2015-02-26 revision 49769) [x86_64-linux]
on Intel(R) Core(TM) i7-4500U CPU @ 1.80GHz
~~~

Run the same test by calling `rake benchmark`.
    
## License

SlowBlink has an MIT license.


## Thanks

Many thanks to the authors of Blink Protocol.


## Contact

Cameron Harper (contact@cjh.id.au)


