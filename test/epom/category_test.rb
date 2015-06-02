require 'test_helper'
require 'epom/category'

class CategoryTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Category
  end

  test "get_publishing_categories" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Category.get_publishing_categories({}, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end

  test "get_advertising_categories" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Category.get_advertising_categories({}, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end
end