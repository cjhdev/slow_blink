require 'mkmf'

$srcs = ['ext_compact_encoder.c', 'blink_stream.c', 'blink_compact.c']
$VPATH << "../../../../ext/slow_blink/message/ext_compact_encoder"
$INCFLAGS << " -I$(srcdir)/../include"
$defs << " -DBLINK_DEBUG_INCLUDE=#include <ruby.h>"
$defs << " -D'BLINK_ERROR(...)=rb_funcall(rb_stderr, rb_intern(\\\"puts\\\"), 1, rb_str_new2(__VA_ARGS__));'"
$defs << " -D'BLINK_DEBUG(...)=rb_funcall(rb_stderr, rb_intern(\\\"puts\\\"), 1, rb_str_new2(__VA_ARGS__));'"

create_makefile('slow_blink/message/ext_compact_encoder', "../../../../assets/ublink/src")

