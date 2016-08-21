SlowBlink
==========

SlowBlink is a Ruby implementation of the [Blink Protocol](http://www.blinkprotocol.org/ "Blink Protocol").

This project is currently under development and not useful.

## Installation

~~~
gem install slow_blink
~~~

## Documentation

Compiled documentation for all releases can be viewed [online](http://www.rubydoc.info/gems/slow_blink "slow_blink").

## Repository Structure

Typical rubygems pattern.

### /lib

SlowBlink Ruby implementation; typically one class per file.

### /ext

C/C++ native extensions:

- /ext/ext_schema_parser

    Flex/Bison configuration files and the generated parser code.


### /specification

The Blink Specification documents that SlowBlink implements.

### /test

`Rake::TestTask` test cases and support files.

## License

SlowBlink has an MIT license.


Cameron Harper 2016

