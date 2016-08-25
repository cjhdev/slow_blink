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

count = 0
time = Time.now
while count < 1000000 do
    Message.to_compact(schema, data)
    count += 1
end

puts "#{count/(Time.now-time)} messages per second"




