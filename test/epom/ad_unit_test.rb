require 'test_helper'
require 'epom/ad_unit'

class AdUnitTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::AdUnit
  end

  test "get_ad_unit_list" do
    timestamp = Time.now.to_i * 1000
    url_params = {
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::AdUnit.get_ad_unit_list(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Fixnum, first['id']
      assert_instance_of Fixnum, first['height']
      assert_instance_of Fixnum, first['width']
      assert_instance_of String, first['name']
    end
  end
end