require './lib/external_api/client.rb'

module SnortApi
  class Client < ExternalApi::Client
    logger ::Logger.new(Rails.root.join('log', 'snort_requests.log').to_s), :debug, :curl

    # Make request with action
    #
    # @params action [Symbol]
    # @params path [String]
    # @params options [Hash]
    # @return [Response]
    #
    def initialize(config, options = {})
      snort_request_logger = ::Logger.new(Rails.root.join("log/snort_requests.log"))
      
      HttpLog.configuration.logger = snort_request_logger

      super
    end

    def make_request(action, path, options)
      super
    end
  end
end
