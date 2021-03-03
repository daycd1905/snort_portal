require './lib/external_api/api.rb'

# SnortApi::Api.new
module SnortApi
  class Api < ExternalApi::Api
    attr_reader :config

    def initialize(options = {})
      @config ||= options[:config] || SnortApi.configuration
    end

    def save_rules(params = {})
      get('/snort_save_rule', params)
    end

    def restart_snort(params)
      get('/snort_restart', params)
    end

    protected

    def client
      @client ||= Client.new(@config)
    end
  end
end