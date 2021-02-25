require './lib/external_api/api.rb'

# SnortApi::Api.new
module SnortApi
  class Api < ExternalApi::Api
    attr_reader :config

    def initialize(options = {})
      @config ||= options[:config] || SnortApi.configuration
    end

    def save_rules(params)
      get('/api/snort_SaleRules', params)
    end

    protected

    def client
      @client ||= Client.new(@config)
    end
  end
end