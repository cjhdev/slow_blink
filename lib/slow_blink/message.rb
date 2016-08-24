module SlowBlink

    class Message

        # @param schema [Schema]
        # @param data [Hash, Array<Hash>] Blink JSON Format
        # @param **opts [Hash] options
        # @raise [Error]        
        def self.compact(schema, data, **opts)
            if data.kind_of? Hash
                data = [data]
            end
            data.inject("") do |out, d|
                out << schema.to_compact(d)
            end    
        end
    
    end

end
