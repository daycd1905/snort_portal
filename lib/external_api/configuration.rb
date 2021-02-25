module ExternalApi
  module Configurable
    # Init configuration with block
    #
    def configure
      yield(configuration) if block_given?
      configuration
    end

    # Init configuration
    #
    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration < OpenStruct
    # Creates a hash of options
    #
    def options
      to_h
    end
  end
end
