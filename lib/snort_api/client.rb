module SnortApi
  class Client < ExternalApi::Client
    # Make request with action
    #
    # @params action [Symbol]
    # @params path [String]
    # @params options [Hash]
    # @return [Response]
    #
    def initialize(config, options = {})
      super
    end

    def make_request(action, path, options)
      super
    end
  end
end
