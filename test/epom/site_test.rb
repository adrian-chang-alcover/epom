require 'test_helper'
require 'epom/site'

class SiteTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Site
  end

  define_get_tests_auto(Epom::Site)

  test "get_sites" do
  	timestamp = Time.now.to_i * 1000
    body_params = {
  		:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  		:timestamp => timestamp, 
  		:username => ENV['username'],
    }
    url_params = {}

  	response = Epom::Site.get_sites(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response.first
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end

  test "get_site_cpm_threshold_summary" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :siteId => ENV['site_id']
    }

    response = Epom::Site.get_site_cpm_threshold_summary(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response.first
      assert_instance_of Hash, first
      assert_instance_of Float, first['cpmThreshold']
    end
  end

  test "get_site_pricing" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :siteId => ENV['site_id']
    }

    response = Epom::Site.get_site_pricing(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of String, response['paymentModel']
    assert_instance_of Float, response['price']
    assert_instance_of String, response['pricingType']
  end

  test "set_site_pricing" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :siteId => ENV['site_id']
    }
    body_params = '{"paymentModel":"FIXED_PRICE","pricingType":"CPM","price":4.2}'

    response = Epom::Site.set_site_pricing(url_params, body_params)
    assert_instance_of Hash, response
    assert response['success']
  end

  test "set_placement_pricing" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :placementId => ENV['placement_id'],
    }
    body_params = '{"paymentModel":"FIXED_PRICE","pricingType":"CPC","price":1.2}'

    response = Epom::Site.set_placement_pricing(url_params, body_params)
    assert_instance_of Hash, response
    assert response['success']
  end

  test "create_site" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :name => "publisher_#{timestamp}",
      :url => 'http://www.publisher.com',
      :email => "publisher@example.com",
      :categoryId => 2
    }

    response = Epom::Site.create_site({}, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert response['success']
  end

  test "get_sites_zones" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :siteId => ENV['site_id']
    }

    response = Epom::Site.get_sites_zones(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end

end
