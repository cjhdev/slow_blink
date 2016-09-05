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

### Serialise a String

We want to serialise a group containing a single string type field.

- The group shall be named 'Hello' and shall be serialisable as type '0'
- The single field shall be named 'greeting' and shall be a string no larger than 42 bytes
- The single field shall be mandatory

~~~ruby
require 'slow_blink'

# create a schema from Blink syntax
buffer = SlowBlink::SchemaBuffer.new("Hello/0 -> string (42) greeting")
schema = SlowBlink::Schema.new(buffer)

# generate a message model from the schema
model = SlowBlink::Message::Model.new(schema)

# create a message instance using the message model
message = model.new do
    group "Hello" do |g|
        g["greeting"] = "hello"
    end
end

# serialise the message instance
compact_form = message.to_compact

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


