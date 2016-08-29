require_relative "capture_stderr"
require "test/unit"
require "slow_blink"

inputs = {}
root = "test/input"

testClass = Class.new(Test::Unit::TestCase) do

    class << self
        attr_accessor :inputs
    end

    Dir.foreach(root) do |filename|

        next if filename == ".." or filename == "."

        test_name = "test_#{filename.sub(".blink", "")}"
        inputs[test_name.to_sym] = {:fileName => filename, :buffer => File.new("#{root}/#{filename}", "r").read}

        define_method( test_name ) do

            output = nil

            # run and intercept stderr output
            #err = capture_stderr do

                output = SlowBlink::Schema.new(SlowBlink::SchemaBuffer.new(inputs[__method__][:buffer], filename: inputs[__method__][:fileName]))
            
            #end

            # there should have been no messages to stderr
            #assert_equal("", err.string, "unexpected error messages")

            # if there were messages, forward them to stderr
            #if err.string != ""

                #STDERR.puts err.string

            #end

            #puts output.to_s

        end

    end

end

# set inputs as a class variable
testClass.inputs = inputs

# name the dynamic test class
Object.const_set("TestInputs", testClass)

