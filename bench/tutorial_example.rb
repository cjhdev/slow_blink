# This is benchmark uses schema and input data taken from the Blink Protocol tutorial here:
#
# http://blinkprotocol.org/s/tutorial.html
#

require "benchmark"
require "slow_blink"
include SlowBlink
include Benchmark

# the schema in blink schema format
rawSchema = <<-eos
    InsertOrder/1 ->
        string Symbol,  # set to "IBM"
        string OrderId, # set to "ABC123"
        u32 Price,      # set to 125
        u32 Quantity    # set to 1000
eos

buffer = SchemaBuffer.new(rawSchema)
schema = Schema.new(buffer)
model = Message::Model.new(schema)

CYCLES = 100000

message = model.group("InsertOrder").new(
    "Symbol" => "IBM",
    "OrderId" => "ABC123",
    "Price" => 125,
    "Quantity" => 1000
)

compact_form = "\x0f\x01\x03\x49\x42\x4d\x06\x41\x42\x43\x31\x32\x33\x7d\xa8\x0f"

puts "schema with data:"
puts ""
puts rawSchema
puts ""
puts "compact form:"
puts ""
puts "    " + compact_form.bytes.map{ |c| sprintf("\\x%02X",c) }.join + "  (#{compact_form.size} bytes)"
puts ""
puts "benchmark:"

Benchmark.benchmark(CAPTION, 50) do |x|
    st = x.report("#{CYCLES} x Schema.new") { CYCLES.times { Schema.new(buffer) } }
    mt = x.report("#{CYCLES} x Message::Model.new") { CYCLES.times { Message::Model.new(schema) } }
    iet = x.report("#{CYCLES} x Message::Model#group.new#encode_compact") { CYCLES.times { model.group("InsertOrder").new("Symbol" => "IBM", "OrderId" => "ABC123", "Price" => 125, "Quantity" => 1000).encode_compact } }
    dt = x.report("#{CYCLES} x Message::Model#decode_compact") { CYCLES.times { model.decode_compact(compact_form.dup) } }
    puts ""
    puts "parse                 #{(CYCLES/st.to_a.last.to_f).to_i} schema/s"
    puts "generate              #{(CYCLES/mt.to_a.last.to_f).to_i} model/s"
    puts "initialise and encode #{(CYCLES/iet.to_a.last.to_f).to_i} message/s    (#{compact_form.size * (CYCLES/iet.to_a.last.to_f).to_i} Bytes/s)"
    puts "decode                #{(CYCLES/dt.to_a.last.to_f).to_i} message/s    (#{compact_form.size * (CYCLES/dt.to_a.last.to_f).to_i} Bytes/s)"
end

puts ""
puts "running #{`ruby --version`}"
puts "on #{`cat /proc/cpuinfo`[/model name.*/].sub(/model\sname\s:\s/,"")}"
