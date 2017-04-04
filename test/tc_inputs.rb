require_relative "capture_stderr"
require "test/unit"
require "slow_blink"

#inputs = {}
#root = File.expand_path(__FILE__)  "test/input"

root = File.expand_path(File.join(File.dirname(__FILE__), "input"))

Dir.foreach(root) do |filename|

    next if filename == ".." or filename == "."

    testClass = Class.new(Test::Unit::TestCase) do

        class << self
            attr_accessor :inputs
        end

        test_name = "test_parse"

        test_name = "test_#{filename.sub(".blink", "")}"
        
        define_method( "test_parse" ) do
            SlowBlink::Schema.read(File.join(root, filename))
        end

        define_method( "test_model" ) do

            #puts "parsing #{filename}"
            schema = SlowBlink::Schema.read(File.join(root, filename))
            #puts "modeling #{filename}"
            model = SlowBlink::Message::Model.new(schema)
            #puts "gen test data"
            testData = SlowBlink::Message::TestData.new(model)

            # self test all serialisable groups
            schema.groups.select{|g|g.id}.each do |g|

                # initialise a group with valid test data
                message = testData.set(g.name)

                # serialise
                msg = message.encode_compact

                # decode
                model.decode_compact(msg)

            end
            
        end

    end

    Object.const_set("TestInputs_#{File.basename(filename, ".blink").gsub("-", "_")}", testClass)

end



