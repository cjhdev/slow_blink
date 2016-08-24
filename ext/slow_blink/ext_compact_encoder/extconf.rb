require 'mkmf'
$CFLAGS += " -std=c99"
create_makefile('slow_blink/ext_compact_encoder')

