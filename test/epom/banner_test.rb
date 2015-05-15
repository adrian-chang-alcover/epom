require 'test_helper'
require 'epom/banner'

class BannerTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Banner
  end

  Epom::Banner.extended_methods.keys.grep(/^get_/).each do |extended_method|
    
    define_method("test_#{extended_method}_auto") do
      url_parameters_signature = Epom::Banner.extended_methods[extended_method][:url_parameters]
      body_parameters_signature = Epom::Banner.extended_methods[extended_method][:body_parameters]

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

      Epom::Banner.send(extended_method, url_params, body_params)
    end
  end

  # #TODO: create banner with LOCAL_FILE
  # test "create_banner" do
  # 	timestamp = Time.now.to_i * 1000
  #   body_params = {
  # 		:campaignId => ENV['campaign_id'], 
  # 		:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  # 		:timestamp => timestamp, 
  # 		:username => ENV['username'],
  #     :weight => 1,
  #     :imageBannerLink => "http://beachgrooves.com/wp-content/uploads/2014/07/BeachGrooves-Logos-website2.png",
  #     :url => "http://www.example.com",
  #     :name => "banner #{timestamp}",
  #     :bannerType => Epom::BannerType::EXTERNAL_FILE,
  #     :adUnitId => 10,
  #     :active => '1',
  #     :placementType => Epom::PlacementType::SITE_PLACEMENT,
  #     :adUnitWidth => 237,#128
  #     :adUnitHeight => 100,#114
  #     # :imageFile => File.new('test/IMG_5457-128x128.JPG')
  #   }

  # 	response = Epom::Banner.create_banner({}, body_params)
  #   assert_instance_of Hash, response
  #   assert_instance_of Fixnum, response['id']
  #   assert_instance_of Fixnum, response['campaignId']
  #   assert_equal ENV['campaign_id'].to_i, response['campaignId']
  # end

  # test "get_banner_ad_unit_values" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #     :placementType => Epom::PlacementType::SITE_PLACEMENT
  #   }

  #   response = Epom::Banner.get_banner_ad_unit_values({}, body_params)
  #   assert_instance_of Array, response
  #   if response.count > 0
  #     first = response.first
  #     assert_instance_of Fixnum, first['id']
  #     assert_instance_of Fixnum, first['height']
  #     assert_instance_of Fixnum, first['width']
  #     assert_instance_of String, first['name']
  #   end
  # end  

  # test "get_banner_pricing" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #   }
  #   url_params = {
  #     :bannerId => ENV['banner_id']
  #   }

  #   response = Epom::Banner.get_banner_pricing(url_params, body_params)
  #   assert_instance_of Hash, response
  #   assert_instance_of Fixnum, response['id']
  #   assert_instance_of String, response['paymentModel']
  # end

  # test "get_placements_for_banner" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #   }
  #   url_params = {
  #     :bannerId => ENV['banner_id']
  #   }

  #   response = Epom::Banner.get_placements_for_banner(url_params, body_params)
  #   assert_instance_of Array, response
  #   if response.count > 0
  #     first = response[0]
  #     assert_instance_of Hash, first
  #     assert_instance_of Fixnum, first['id']
  #     assert_instance_of String, first['name']
  #   end
  # end

  # test "get_targetings" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #   }
  #   url_params = {
  #     :bannerId => ENV['banner_id']
  #   }

  #   response = Epom::Banner.get_targetings(url_params, body_params)
  #   assert_instance_of Array, response
  #   if response.count > 0
  #     first = response[0]
  #     assert_instance_of Hash, first
  #     assert_instance_of Fixnum, first['id']
  #     assert_instance_of String, first['rule']
  #     assert_instance_of String, first['type']
  #   end
  # end

  # test "get_advertising_categories" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #   }

  #   response = Epom::Banner.get_advertising_categories({}, body_params)
  #   assert_instance_of Array, response
  #   if response.count > 0
  #     first = response[0]
  #     assert_instance_of Hash, first
  #     assert_instance_of Fixnum, first['id']
  #     assert_instance_of String, first['name']
  #   end
  # end

  # test "get_banner" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #   }
  #   url_params = {
  #     :bannerId => ENV['banner_id']
  #   }

  #   response = Epom::Banner.get_banner(url_params, body_params)
  #   assert_instance_of Hash, response
  #   assert_instance_of Fixnum, response['campaignId']
  #   assert_instance_of String, response['url']
  #   assert_instance_of String, response['name']
  #   assert_instance_of String, response['bannerType']
  #   assert_instance_of Fixnum, response['adUnitId']
  #   assert_instance_of String, response['placementType']
  # end

  # test "get_publishing_categories" do
  #   timestamp = Time.now.to_i * 1000
  #   body_params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #   }

  #   response = Epom::Banner.get_publishing_categories({}, body_params)
  #   assert_instance_of Array, response
  #   if response.count > 0
  #     first = response[0]
  #     assert_instance_of Hash, first
  #     assert_instance_of Fixnum, first['id']
  #     assert_instance_of String, first['name']
  #   end
  # end
end