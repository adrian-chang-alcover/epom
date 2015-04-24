require 'test_helper'
require 'epom/banner'
require 'epom/banner_type'
require 'epom/placement_type'
require 'epom/ad_unit_size'

class BannerTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Banner
  end

  test "create_banner" do
  	timestamp = Time.now.to_i * 1000
    params = {
  		:campaignId => 1247, 
  		:hash => Epom.create_hash(Epom.create_hash('kewelta'), timestamp),
  		:timestamp => timestamp, 
  		:username => 'kewelta',
      :placementType => Epom::PlacementType::SITE_PLACEMENT,
      :active => true,
      :name => "banner #{timestamp}",
      :adUnitId => 3
    }
  	begin
    	response = Epom::Banner.create_banner(params)
      assert_instance_of Hash, response
      assert_instance_of Fixnum, response['id']
    rescue SocketError => e
      assert_equal "getaddrinfo: Name or service not known", e.message
    end 
  end

  test "get_banner_ad_unit_values" do
    # timestamp = Time.now.to_i * 1000
    # params = {
    #   :hash => Epom.create_hash(Epom.create_hash('kewelta'), timestamp),
    #   :timestamp => timestamp, 
    #   :username => 'kewelta',
    #   :placementType => Epom::PlacementType::SITE_PLACEMENT
    # }
    # begin
    #   response = Epom::Banner.get_banner_ad_unit_values(params)
    #   assert_instance_of Array, response
    #   if response.count > 0
    #     first = response.first
    #     assert_instance_of Fixnum, first['id']
    #     assert_instance_of Fixnum, first['height']
    #     assert_instance_of Fixnum, first['width']
    #     assert_instance_of String, first['name']
    #   end
    # rescue SocketError => e
    #   assert_equal "getaddrinfo: Name or service not known", e.message
    # end 
  end

  
end