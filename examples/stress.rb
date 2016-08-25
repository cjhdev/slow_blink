require "slow_blink"
include SlowBlink

input = <<-eos
OrderExecuted/0x4c ->
    string Symbol,
    u64 OrderId,
    u32 Price,
    u32 Qty,
    u32 MatchId
eos

schema = Schema.parse(input)
data = [
    {
        "$type" => "OrderExecuted",
        "Symbol" => "SPY",
        "OrderId" => 4469263,
        "Price" => 13550,
        "Qty" => 200,
        "MatchId" => 6902
    }
]

CYCLES = 1000000

count = 0
time = Time.now
while count < CYCLES do
    schema.to_compact(data)
    count += 1
end
encodeTime = count/(Time.now-time)
=begin
compactForm = schema.to_compact(data)
count = 0
time = Time.now
while count < CYCLES
    schema.from_compact!(input.dup)
    count += 1
end
decodeTime = count/(Time.now-time)
=end

puts "encoding #{encodeTime} message per second"
#puts "decoding #{decodeTime} message per second"










