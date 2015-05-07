require 'test_helper'
require 'epom/site'

class SiteTest < ActiveSupport::TestCase
	# test "truth" do
 #    assert_kind_of Class, Epom::Site
 #  end

 #  test "get_sites" do
 #  	timestamp = Time.now.to_i * 1000
 #    params = {
 #  		:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #  		:timestamp => timestamp, 
 #  		:username => ENV['username'],
 #    }

 #  	response = Epom::Site.get_sites(params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response.first
 #      assert_instance_of Hash, first
 #      assert_instance_of Fixnum, first['id']
 #      assert_instance_of String, first['name']
 #    end
 #  end

 #  test "get_site_cpm_threshold_summary" do
 #    timestamp = Time.now.to_i * 1000
 #    params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :siteId => ENV['site_id']
 #    }

 #    response = Epom::Site.get_site_cpm_threshold_summary(params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response.first
 #      assert_instance_of Hash, first
 #      assert_instance_of Float, first['cpmThreshold']
 #    end
 #  end

 #  test "get_site_pricing" do
 #    timestamp = Time.now.to_i * 1000
 #    params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :siteId => ENV['site_id']
 #    }

 #    response = Epom::Site.get_site_pricing(params)
 #    assert_instance_of Hash, response
 #    assert_instance_of String, response['paymentModel']
 #    assert_instance_of Float, response['price']
 #    assert_instance_of String, response['pricingType']
 #  end

  test "set_site_pricing" do
    timestamp = Time.now.to_i * 1000
    params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :siteId => ENV['site_id'],
      :paymentModel => "{\"paymentModel\":\"FIXED_PRICE\",\"pricingType\":\"CPM\",\"price\":2.0}"
    }

    response = Epom::Site.set_site_pricing(params)
  end

 #  test "set_placement_pricing" do
 #    timestamp = Time.now.to_i * 1000
 #    params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :placementId => ENV['placement_id'],
 #      :paymentModel => ''
 #    }

 #    response = Epom::Site.set_placement_pricing(params)
 #  end

  # test "create_site" do
  #   timestamp = Time.now.to_i * 1000
  #   params = {
  #     :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  #     :timestamp => timestamp, 
  #     :username => ENV['username'],
  #     :name => "publisher_#{timestamp}",
  #     :url => 'http://www.publisher.com',
  #     :email => "publisher@example.com",
  #     :categoryId => 2
  #   }

  #   response = Epom::Site.create_site(params)
  #   assert_instance_of Hash, response
  #   assert_instance_of Fixnum, response['id']
  #   assert response['success']
  # end

end
