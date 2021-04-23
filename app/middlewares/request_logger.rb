class RequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    request_headers = env
      .select { |k,v| k.start_with?('HTTP_') }
      .map { |pair| [pair[0].sub(/^HTTP_/, ''), pair[1]].join(': ') }
      .sort

    request_params = env['rack.request.form_hash']
    unless request_params
      rack_input         = env['rack.input']
      rack_input_content = rack_input.read
      request_params     = JSON.parse(rack_input_content) rescue rack_input_content
      rack_input.rewind
    end
    path_info    = env['ORIGINAL_FULLPATH']
    request_type = if path_info.start_with?('/api/snort')
                     'Snort Request'
                   else
                     'Web Request'
                   end

    log_messsage = ''
    log_messsage += "[RequestLogger][#{timestamp}] START #{request_type}: #{env['REQUEST_METHOD']} #{path_info} \n"
    log_messsage += "[RequestLogger][#{timestamp}] Request Header: #{request_headers} \n"
    log_messsage += "[RequestLogger][#{timestamp}] Request Params: #{request_params} \n"

    response = @app.call(env).tap do |response|
      response_status, response_headers, response_body = *response

      log_messsage += "[RequestLogger][#{timestamp}] Response Status: #{response_status} \n"
      log_messsage += "[RequestLogger][#{timestamp}] Response Headers: #{response_headers} \n"

      if path_info.start_with?('/api')
        log_messsage += "[RequestLogger][#{timestamp}] Response Body: \n"
        response_body.each { |line| log_messsage += "[RequestLogger][#{timestamp}] \t#{line} \n" }
      end
    end

    log_messsage += "[RequestLogger][#{timestamp}] END #{request_type}: #{env['REQUEST_METHOD']} #{path_info} \n"
    log_messsage += ''

    Rails.logger.info log_messsage

    response
  end

  def timestamp
    Time.now.iso8601(10)
  end
end
