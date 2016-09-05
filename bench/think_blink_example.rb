# This is benchmark uses schema and input data taken from the "Think Blink" blog:
#
# http://blog.blinkprotocol.org/2013/01/blink-compared-to-google-protocol.html
#

require "benchmark"
require "slow_blink"
include SlowBlink

# the schema in blink schema format
rawSchema = <<-eos
OrderExecuted/0x4c ->
    string Symbol,
    u64 OrderId,
    u32 Price,
    u32 Qty,
    u32 MatchId
eos

model = Message::Model.new(Schema.new(SchemaBuffer.new(rawSchema)))

CYCLES = 1000000

output = model.group("OrderExecuted") do |g|
    g["Symbol"] = "SPY"
    g["OrderId"] = 4467995
    g["Price"] = 13548
    g["Qty"] = 100
    g["MatchId"] = 6911
end

input = "\x0e\x4c\x03\x53\x50\x59\x82\x90\xda\x1b\xe9\x6c\x64\xb5\x7f"

puts output.to_compact("").bytes.map{ |c| sprintf("\\x%02X",c) }.join
#puts input.bytes.map{ |c| sprintf("\\x%02X",c) }.join



Benchmark.bm do |x|
    x.report("to_compact") { CYCLES.times { output.to_compact("") } }
    x.report("to_compact") { CYCLES.times { model.decode_compact(input) } }
end

=begin

schema = Schema.new(SchemaBuffer.new(rawSchema))

model = Message::Model.new(schema)
#input = "\x0e\x4c\x03\x53\x50\x59\x82\x90\xda\x1b\xe9\x6c\x64\xb5\x7f"
input = "\x0b\x4c\x05hello\x00\x01\x02\x03"

message = model.group("OrderExecuted") do
    field("Symbol").set "SPY"
    field("OrderId").set 4467995
    field("Price").set 13548
    field("Qty").set 100
    field("MatchId").set 6911
end

size = message.to_compact("").size



CYCLES = 1000000



puts "real time measurements averaged over "

parse=0
to_compact=0
from_compact=0

CYCLES.times do
    parse += Benchmark.realtime { Schema.new(SchemaBuffer.new(rawSchema)) }
end

CYCLES.times do
    to_compact += Benchmark.realtime { message.to_compact("") }
end


CYCLES.times do
    from_compact += Benchmark.realtime { model.from_compact(input.dup) }
end

avg_parse = parse / CYCLES
avg_to_compact = to_compact / CYCLES
avg_from_compact = from_compact / CYCLES

puts "#{(1/avg_parse).round(2)} schema/s (parse)"
puts "#{(1/avg_to_compact).round(2)} message/s (to_compact)"
puts "#{(1/avg_from_compact).round(2)} message/s (from_compact) "

puts "#{(1/avg_to_compact*size).round} bytes/s (to_compact)"
puts "#{(1/avg_from_compact*input.size).round} bytes/s (from_compact) "

=end
