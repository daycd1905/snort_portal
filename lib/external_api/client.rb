require 'httparty'

module ExternalApi
  class Client
    include HTTParty

    # TODO Move to environment variable
    DEFAULT_TIMEOUT = 900

    default_timeout DEFAULT_TIMEOUT

    query_string_normalizer proc { |query|
      query.map { |k, v|
        v.is_a?(Array) ? v.map { |sv| "#{k}=#{sv}" } : "#{k}=#{v}"
      }.join('&')
    }

    # Constructor
    #
    # @params config [Configuration]
    # @return [Hash]
    #
    def initialize(config, options = {})
      @options = options
      @config  = config

      self.class.base_uri @config.endpoint
    end

    # Make request with post method
    #
    # @params path [String] request path
    # @params params [Hash] request params
    # @params options [Hash] request options
    # @return [Response]
    #
    def post(path, params, custom_options = {})
      options = request_options(params, custom_options)
      make_request(:post, path, options)
    end

    def put(path, params, custom_options = {})
      options = request_options(params, custom_options)
      make_request(:put, path, options)
    end

    def get(path, params, custom_options = {})
      options = request_options(params, custom_options)
      make_request(:get, path, options)
    end

    protected

    def request_options(body, custom_options = {})
      request_headers = { 'Content-Type' => custom_options[:content_type] || 'application/json' }
      request_headers.merge!({ 'Authorization' => custom_options[:authorization] }) if custom_options[:authorization]
      request_basic_auth = (@config.username && @config.password) ? { username: @config.username, password: @config.password } : nil
      request_body = (custom_options[:content_type] == 'application/x-www-form-urlencoded') ? body : body.to_json
      request_query = custom_options[:query] || nil
      request_timeout = custom_options[:timeout] || DEFAULT_TIMEOUT

      {
        headers:    request_headers,
        basic_auth: request_basic_auth,
        body:       request_body,
        query:      request_query,
        timeout:    request_timeout
      }
    end


    # Make request with action
    #
    # @params action [Symbol]
    # @params path [String]
    # @params options [Hash]
    # @return [Response]
    #
    def make_request(action, path, options)
      response = self.class.send(action, path, options.merge(logger: nil))
      parse_response(response, options)
    end

    # Parse resonse of httparty to lib response
    #
    # @params response [HTTParty]
    # @return [Response]
    #
    def parse_response(response, options = {})
      ExternalApi::Response.new(response, options)
    end
  end
end
