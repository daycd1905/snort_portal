module ExternalApi
  class Api
    protected

    def client
      @client ||= Client.new(@config)
    end

    def get(path, params = {})
      client.get prefix_path(path), params, options.merge(query: params)
    end

    def options
      {}
    end

    def post(path, params = {})
      client.post prefix_path(path), params, options
    end

    def prefix_path(path)
      "#{@config.prefix_path}#{path}"
    end

    def put(path, params = {})
      client.put prefix_path(path), params, options
    end
  end
end
