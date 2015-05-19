require 'test_helper'

class EpomTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Epom
  end

  test "get_targeting" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
      :bannerId => ENV['banner_id'],
      :targetId => ENV['target_id']
    }

    response = Epom::Banner.get_targeting(url_params, body_params)
    assert_instance_of Hash, response
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
end
