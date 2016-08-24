module SlowBlink

    class Message

        # Create a message instance from Blink JSON form data and a schema
        #
        #
        # @param schema [Schema]
        # @param data [Hash, Array<Hash>] Blink JSON Format
        # @param **opts [Hash] options
        # @raise [Error]        
        def initialize(schema, data, **opts)
            @schema = schema
            if data.kind_of? Hash
                @data = [data]
            else
                @data = data
            end        
            @data.each do |d|
                @schema.validate_json(d)        
            end            
        end

        # Create a message instance from Blink compact form data and a schema
        #
        # @param schema [Schema]
        # @param data [String] compact form encoding
        # @return [Message]
        # @raise [Error]
        def self.from_compact!(schema, data)
            # data = schema.from_compact!(data)
            # self.new(schema, data)
        end

        # Create a Blink compact form data string from a message instance
        #
        # @return [String] compact form encoding
        def to_compact
            out = ""
            @data.each do |i|
                out << @schema.to_compact(i)
            end
            out
        end

        # Create a Blink JSON form data structure from message instance
        #
        # @return [Array<Hash>] Blink JSON format
        def to_json
            @data
        end
            
    end

end
