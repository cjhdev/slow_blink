# This is benchmark uses schema and input data taken from the "Think Blink" blog:
#
# http://blog.blinkprotocol.org/2013/01/blink-compared-to-google-protocol.html
#

require "benchmark"
require "slow_blink"
include SlowBlink
include Benchmark

# the schema in blink schema format
rawSchema = <<-eos
OrderExecuted/0x4c ->
    string Symbol,
    u64 OrderId,
    u32 Price,
    u32 Qty,
    u32 MatchId
eos

schema = Schema.new(SchemaBuffer.new(rawSchema))

model = Message::Model.new(schema)
input = "\x0b\x4c\x05hello\x00\x01\x02\x03"

CYCLES = 10000

puts "real time measurements averaged over "

parse=0
to_compact=0
from_compact=0

CYCLES.times do
    parse += Benchmark.realtime { Message::Model.new(Schema.new(SchemaBuffer.new(rawSchema))) }
end
=begin
CYCLES.times do
    to_compact += Benchmark.realtime { schema.to_compact(data) }
end
=end

CYCLES.times do
    from_compact += Benchmark.realtime { model.from_compact(input.dup) }
end

avg_parse = parse / CYCLES
#avg_to_compact = to_compact / CYCLES
avg_from_compact = from_compact / CYCLES

puts "#{(1/avg_parse).round(2)} schema/s (parse)"
#puts "#{(1/avg_to_compact).round(2)} message/s (to_compact)"
puts "#{(1/avg_from_compact).round(2)} message/s (from_compact) "

#puts "#{(1/avg_to_compact*compact.size).round} bytes/s (to_compact)"
puts "#{(1/avg_from_compact*input.size).round} bytes/s (from_compact) "

