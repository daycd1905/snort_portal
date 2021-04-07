module EventService
  class DecodeEventDetail
    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def execute
      xxd.split("\n");
    end

    private

    def decode_hexa
      [payload].pack("H*")
    end

    def xxd
      Xxd.dump(decode_hexa)
    end
  end
end