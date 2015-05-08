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
    body_params = {
  		:campaignId => ENV['campaign_id'], 
  		:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  		:timestamp => timestamp, 
  		:username => ENV['username'],

      :weight => 1,
      :thirdTrackingCode => '',
      :allowNewPlacementsAutoLinking => false,
      :width => 237,
      :flashBannerLink => '',
      :imageBannerLink => "http://beachgrooves.com/wp-content/uploads/2014/07/BeachGrooves-Logos-website2.png",
      :url => "http://www.example.com",
      :height => 100,
      :name => "banner #{timestamp}",
      :bannerType => Epom::BannerType::EXTERNAL_FILE,
      :adUnitId => 10,
      :active => true,
      :placementType => Epom::PlacementType::SITE_PLACEMENT,
      :adUnitWidth => 237,
      :adUnitHeight => 100
    }

  	response = Epom::Banner.create_banner({}, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_instance_of Fixnum, response['campaignId']
    assert_equal ENV['campaign_id'].to_i, response['campaignId']
  end

  test "get_banner_ad_unit_values" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :placementType => Epom::PlacementType::SITE_PLACEMENT
    }

    response = Epom::Banner.get_banner_ad_unit_values({}, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response.first
      assert_instance_of Fixnum, first['id']
      assert_instance_of Fixnum, first['height']
      assert_instance_of Fixnum, first['width']
      assert_instance_of String, first['name']
    end
  end  

  test "get_banner_pricing" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :bannerId => ENV['banner_id']
    }

    response = Epom::Banner.get_banner_pricing(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_instance_of String, response['paymentModel']
  end

  test "get_placements_for_banner" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :bannerId => ENV['banner_id']
    }

    response = Epom::Banner.get_placements_for_banner(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end

  test "get_targetings" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :bannerId => ENV['banner_id']
    }

    response = Epom::Banner.get_targetings(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['rule']
      assert_instance_of String, first['type']
    end
  end

  test "get_advertising_categories" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Banner.get_advertising_categories({}, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end

  test "get_banner" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :bannerId => ENV['banner_id']
    }

    response = Epom::Banner.get_banner(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['campaignId']
    assert_instance_of String, response['url']
    assert_instance_of String, response['name']
    assert_instance_of String, response['bannerType']
    assert_instance_of Fixnum, response['adUnitId']
    assert_instance_of String, response['placementType']
  end

  test "get_publishing_categories" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Banner.get_publishing_categories({}, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end
end