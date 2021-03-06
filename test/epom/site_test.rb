require 'test_helper'
require 'epom/site'

class SiteTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Site
  end

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

  test "get_sites_tree" do
    timestamp = Time.now.to_i * 1000
    url_params = {}
    body_params = {}

    response = Epom::Site.get_sites_tree(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
      assert_instance_of Array, first['zones']
      if first['zones'].count > 0
        first = first['zones'][0]
        assert_instance_of Hash, first
        assert_instance_of Fixnum, first['id']
        assert_instance_of Array, first['placements']
        if first['placements'].count > 0
          first = first['placements'][0]
          assert_instance_of Hash, first
          assert_instance_of Fixnum, first['id']
          assert_instance_of String, first['name']
        end
      end
    end
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

  # ***** INCOMPATIBLE WITH set_site_pricing TEST *****
  # test 'update_country_pricing' do
  #   url_params = {
  #     :siteId => ENV['site_id'],
  #     :countryCode => ENV['country_code']
  #   }
  #   body_params = {
  #     :price => 2.33
  #   }

  #   response = Epom::Site.update_country_pricing(url_params, body_params)
  #   assert_not_instance_of Fixnum, response
  # end

  test 'garbage_collector' do
    if Epom.config.epom_server == 'https://n29.epom.com/'
      sites = Epom::Site.get_sites({})
      sites.each do |site|
        Epom::Site.delete_site({siteId: site['id']}) unless site['id'] == ENV['site_id'].to_i
      end
    end
  end

  define_get_tests_auto(Epom::Site)
end
