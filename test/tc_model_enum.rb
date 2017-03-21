require "test/unit"
require 'slow_blink'

class TestModelEnum < Test::Unit::TestCase

    include SlowBlink

    def setup

        syntax = <<-eos
        Singleton = | Lonely

        Size = Small | Medium | Large

        ExplicitSize = Small/38 | Medium/40 | Large/42

        Colour = Red/0xff0000 | Green/0x00ff00 | Blue/0x0000ff

        Message/0 ->
            Singleton One,
            Size Two,
            ExplicitSize Three,
            Colour Four    
eos
    
        schema = Schema.new(syntax)
        @model = Message::Model.new(schema)        
    end

    def test_init

        message = @model.group("Message").new(
            "One" => "Lonely",
            "Two" => "Small",
            "Three" => "Medium",
            "Four" => "Blue"
        )

        assert_equal("Lonely", message["One"])
        assert_equal("Small", message["Two"])
        assert_equal("Medium", message["Three"])
        assert_equal("Blue", message["Four"])

    end
    
end

