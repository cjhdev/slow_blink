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

schema = Schema.parse(rawSchema)

# one message shall be 10 groups of input data (note. we don't bother changing the field values)
data = Array.new(10) do
    {
        "$type" => "OrderExecuted",
        "Symbol" => "SPY",
        "OrderId" => 4469263,
        "Price" => 13550,
        "Qty" => 200,
        "MatchId" => 6902
    }
end

compact = schema.to_compact(data)

CYCLES = 1000

puts "real time measurements averaged over "

parse=0
to_compact=0
from_compact=0

CYCLES.times do
    parse += Benchmark.realtime { Schema.parse(rawSchema) }
end

CYCLES.times do
    to_compact += Benchmark.realtime { schema.to_compact(data) }
end

CYCLES.times do
    from_compact += Benchmark.realtime { schema.from_compact(compact) }
end

avg_parse = parse / CYCLES
avg_to_compact = to_compact / CYCLES
avg_from_compact = from_compact / CYCLES

puts "#{(1/avg_parse).round(2)} schema/s (parse)"
puts "#{(1/avg_to_compact).round(2)} message/s (to_compact)"
puts "#{(1/avg_from_compact).round(2)} message/s (from_compact) "

puts "#{(1/avg_to_compact*compact.size).round} bytes/s (to_compact)"
puts "#{(1/avg_from_compact*compact.size).round} bytes/s (from_compact) "

