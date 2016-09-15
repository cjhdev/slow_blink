require "test/unit"
require 'slow_blink'

class TestIncrAnnote < Test::Unit::TestCase

    include SlowBlink

    def test_schema

        raw =  <<-eos
            Thing
            AnotherThing ->
                string Greeting

            schema <- @test="test"
        eos

        schema = Schema.new(SchemaBuffer.new(raw))

    end

end
