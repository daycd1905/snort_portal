# SnortApiService::SaveRule.new.execute
module SnortApiService
  class SaveRule
    attr_reader :api_client

    def initialize
      @api_client ||= SnortApi::Api.new
    end

    def execute
      error_message = ""

      begin
        resp = call_api

        fail error_message = resp.body["error"] unless resp.success?
      rescue StandardError => error
        error
      end
    end

    private

    def call_api
      api_client.save_rules({})
    end
  end
end