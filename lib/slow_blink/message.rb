module SlowBlink

    class Message

        # Create Message
        #
        # @param schema [Schema]
        # @param input [Hash, Array<Hash>] Blink JSON Format
        # @param **opts [Hash] options
        def initialize(schema, input, **opts)
            @schema = schema
            if input.kind_of? Hash
                @input = [input]
            else
                @input = input
            end
        
            #@input.each do |i|
                #@schema.group(type).validate(i)
            #end            
        end

        # Convert compact form encoding to a message according to schema
        #
        # @param schema [Schema]
        # @param input [String] compact form encoding
        # @return [Message]
        def self.from_compact(schema, input)
            raise
        end

        # Convert message to compact form encoding
        #
        # @return [String] compact form encoding
        def to_compact
            out = ""
            @input.each do |i|
                out << @schema.group(i["$type"]).encode_compact(i, dynamic: true)
            end
            out
        end

        # Convert message to Blink JSON format
        #
        # @return [String] Blink JSON format
        def to_json
            @input
        end
            
    end

end
