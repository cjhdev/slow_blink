SlowBlink
==========

[![Build Status](https://travis-ci.org/cjhdev/slow_blink.svg?branch=master)](https://travis-ci.org/cjhdev/slow_blink)
[![Gem Version](https://badge.fury.io/rb/slow_blink.svg)](https://badge.fury.io/rb/slow_blink)


SlowBlink is a Ruby implementation of the [Blink Protocol](http://www.blinkprotocol.org/ "Blink Protocol").

This project is currently under development and not very useful.


## Highlights

- Integrated and complete Blink Protocol schema parser built on GLR Flex/Bison
- VLC encode/decode functions implemented as native extensions
- 'message' models generated dynamically from Blink schema (no compilation step necessary)
- A complete message serialisation solution dependent only on MRI


## Installation

~~~
gem install slow_blink
~~~


## Short Example

Define a group composed of one string type field.

- The group shall be named 'DemoGroup' and shall be assigned type tag '0'
- The single field shall be named 'fieldName' and shall be a string no larger than 42 bytes

```ruby
require 'slow_blink'
include SlowBlink
schema = Schema.parse("DemoGroup/0 -> string size(42) fieldName")
```

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


