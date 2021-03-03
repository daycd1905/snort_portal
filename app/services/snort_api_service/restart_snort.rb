# SnortApiService::RestartSnort.new.execute
module SnortApiService
  class RestartSnort
    attr_reader :api_client

    def initialize
      @api_client ||= SnortApi::Api.new
    end

    def execute
      error_message = ""

      begin
        resp = call_api

        fail error_message = resp.body["error"] unless resp.success?
      rescue StandardError => e
        error_message
      end
    end

    private

    def call_api
      api_client.restart_snort({})
    end
  end
end