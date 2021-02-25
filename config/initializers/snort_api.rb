require 'snort_api/configuration'
require 'snort_api/response'
require 'snort_api/client'
require 'snort_api/api'

SnortApi.configure do |config|
  config.endpoint    = (ENV['SNORT_API_ENDPOINT'] || 'http://10.10.2.2:5000/')
  config.prefix_path = (ENV['SNORT_API_PREFIX_PATH'] || 'api')
end
