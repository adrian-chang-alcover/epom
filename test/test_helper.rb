require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'yaml'
env_file = File.join(Pathname.new(__FILE__).parent.parent, 'config', 'application.yml')
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key.to_s] = value.to_s
end if File.exists?(env_file)

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

def define_get_tests_auto(klass)
	klass.extended_methods.keys.grep(/^get_/).each do |extended_method|
    klass_name = klass.name.include?('::') ? klass.name.split('::').last : klass.name
    klass_test = "#{klass_name}Test".constantize
    unless klass_test.instance_methods.include?("test_#{extended_method}".to_sym)
      define_method("test_#{extended_method}_auto") do
        url_parameters_signature = klass.extended_methods[extended_method][:url_parameters]
        body_parameters_signature = klass.extended_methods[extended_method][:body_parameters]

        url_params = {}
        if url_parameters_signature
          url_parameters_signature.each do |url_parameter|
            url_params[url_parameter] = ENV[url_parameter.to_s.underscore]
          end
        end

        body_params = {}
        body_parameters_signature.each do |body_parameter|
          body_params[body_parameter] = ENV[body_parameter.to_s.underscore]
        end
        timestamp = Time.now.to_i * 1000
        body_params[:timestamp] = timestamp
        body_params[:hash] = Epom.create_hash(Epom.create_hash(ENV['password']), timestamp)

        response = klass.send(extended_method, url_params, body_params)
        assert_not_instance_of Fixnum, response
      end
    end
	end
end
