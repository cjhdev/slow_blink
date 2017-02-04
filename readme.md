SlowBlink
==========

[![Build Status](https://travis-ci.org/cjhdev/slow_blink.svg?branch=master)](https://travis-ci.org/cjhdev/slow_blink)
[![Gem Version](https://badge.fury.io/rb/slow_blink.svg)](https://badge.fury.io/rb/slow_blink)

SlowBlink is a Ruby implementation of [Blink Protocol](http://www.blinkprotocol.org/ "Blink Protocol").

## Highlights

- Implements Blink Specification [beta4-2013-06-14](specification/blink/BlinkSpec-beta4.pdf "Blink Specification").
- Integrated Blink Protocol schema parser
- Dynamic message model generator
    - Does not generate constants or symbols
- Support for compact mode serialisation
- C codec generator

## Todo

- More tests
- Support `SlowBlink::Message::DATE`
- More debug features (error messages involving anonymous classes are confusing)
- Annotations are parsed but ignored

## Installation

~~~
gem install slow_blink
~~~

Requires Ruby 2.0 and support for building native extensions.

## Examples

see `examples`

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


