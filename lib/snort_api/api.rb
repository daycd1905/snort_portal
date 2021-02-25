# HQApi::Api.new
module HQApi
  class Api < ExternalApi::Api
    attr_reader :config

    def initialize(options = {})
      @config ||= options[:config] || HQApi.configuration
    end

    

    protected

    def client
      @client ||= Client.new(@config)
    end
  end
end