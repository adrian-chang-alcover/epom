require 'test_helper'
require 'epom/zone'

class ZoneTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Zone
  end

  test "create_zone" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :name => "zone #{timestamp}",
      :description => "description",
      :siteId => ENV['site_id']
    }
    url_params = {
    }

    response = Epom::Zone.create_zone(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert response['success']
  end

  test "update_zone" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :name => "zone #{timestamp}",
      :description => "description",
      :zoneId => ENV['zone_id'],
      :siteId => ENV['site_id']
    }
    url_params = {
    }

    response = Epom::Zone.update_zone(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert response['success']
  end

  test "get_zone_placement" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
    url_params = {
    	:zoneId => ENV['zone_id']
    }

    response = Epom::Zone.get_zone_placement(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
    	first = response[0]
    	assert_instance_of Fixnum, first['id']
    	assert_instance_of String, first['name']
    end
  end
end