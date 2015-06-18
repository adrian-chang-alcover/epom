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

def set_environment_variables
  ENV['advertiser_id'] = create_advertiser.to_s
  ENV['campaign_id'] = create_campaign.to_s
  ENV['banner_id'] = create_banner.to_s

  ENV['site_id'] = create_site.to_s
  ENV['zone_id'] = create_zone.to_s
  ENV['placement_id'] = create_standard_placement.to_s
  
  ENV['banner_type'] = 'LOCAL_FILE'
  ENV['target_id'] = '4034'
  ENV['os_name'] = 'UNSPECIFIED'
  ENV['placement_type'] = 'SITE_PLACEMENT'
  ENV['country_code'] = 'US'
  ENV['region_name'] = 'New York'
  ENV['action_key'] = 'cd6091a6b570ac1a0f5d9e0d396220fb-526-1247'
end

def create_advertiser
  body_params = {
    :name => "advertiser #{DateTime.now}",
    :contactName => "advertiser contactName",
    :contactEmail => "advertiser@gmail.com",
    :description => "advertiser description"
  }
  response = Epom::Advertiser.create_advertiser({}, body_params)
  response['id']
end

def create_campaign
  body_params = {
    :advertiserId => ENV['advertiser_id'], 
    :name => "campaign #{DateTime.now}",
    :description => "description for campaign #{DateTime.now}",
    :active => true
  }
  response = Epom::Campaign.create_campaign({}, body_params)
  response['id']
end

def create_banner
  body_params = {
    :campaignId => ENV['campaign_id'], 
    :weight => 1,
    :imageBannerLink => "http://beachgrooves.com/wp-content/uploads/2014/07/BeachGrooves-Logos-website2.png",
    :url => "http://www.example.com",
    :name => "banner #{DateTime.now}",
    :bannerType => Epom::BannerType::EXTERNAL_FILE,
    :adUnitId => 10,
    :active => '1',
    :placementType => Epom::PlacementType::SITE_PLACEMENT,
    :adUnitWidth => 237,
    :adUnitHeight => 100,
  }
  response = Epom::Banner.create_banner({}, body_params)
  response['id']
end

def create_site
  body_params = {
    :name => "publisher_#{DateTime.now}",
    :url => 'http://www.publisher.com',
    :email => "publisher@example.com",
    :categoryId => 2
  }
  response = Epom::Site.create_site({}, body_params)
  response['id']
end

def create_zone
  body_params = {
    :name => "zone #{DateTime.now}",
    :description => "description",
    :siteId => ENV['site_id']
  }
  response = Epom::Zone.create_zone({}, body_params)
  response['id']
end

def create_standard_placement
  body_params = {
    :zoneId => ENV['zone_id'],
    :type => Epom::PlacementType::SITE_PLACEMENT,
    :name => "placement #{DateTime.now}",
    :adUnitId => 10,
    'size.height' => 200,
    'size.width' => 350,
  }
  response = Epom::Placement.create_standard_placement({}, body_params)
  response['id']
end


Epom::EpomElement.login(ENV['username'], ENV['password'])