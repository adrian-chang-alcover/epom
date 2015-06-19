require 'active_support/configurable'

module Epom
  # Configures global settings for Epom
  #   Epom.configure do |config|
  #     config.epom_server = 'https://n29.epom.com/'
  #   end
  def self.configure(&block)
    yield @config ||= Epom::Configuration.new
  end

  # Global settings for Epom
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :public_key
    config_accessor :private_key
    config_accessor :epom_server

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.epom_server = 'https://n29.epom.com/'
  end
end
