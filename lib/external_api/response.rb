module ExternalApi
  class Response
    attr_reader :response_text

    # Constructor
    #
    # @params response [HTTParty::Response]
    #
    def initialize(response_text, options = {})
      @response_text = response_text
      @options  = options
    end

    # Response status
    #
    # @return status [Integer]
    #
    def status
      @status ||= response_text.code
    end

    def header
      @header ||= @response_text.header
    end

    # Response body
    #
    # @return body [Hash]
    #
    def body
      @body ||= (JSON.parse(response_body) rescue { text: response_body }) if response_body.present?
    end

    def response_body
      @response_body ||= @response_text.body
    end

    # Check success response
    #
    # @return true/false [boolean]
    #
    def success?
      @response_text.success?
    end

    # Check timeout response
    #
    # @return true/false [boolean]
    #
    def timeout?
      status == 504
    end
  end
end
