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

output = model.group("OrderExecuted").new(
    "Symbol" => "SPY",
    "OrderId" => 4467995,
    "Price" => 13548,
    "Qty" => 100,
    "MatchId" => 6911
)

input = "\x0E\x4C\x03\x53\x50\x59\xC3\x1B\x2D\x44\xAC\xD3\x64\xBF\x6B"

Benchmark.bm do |x|
    x.report("encode_compact") { CYCLES.times { output.encode_compact } }
    x.report("decode_compact") { CYCLES.times { model.decode_compact(input) } }
end
