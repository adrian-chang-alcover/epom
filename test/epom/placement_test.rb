require 'test_helper'
require 'epom/placement'

class PlacementTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Placement
  end

  test "get_placement_summary" do
  	timestamp = Time.now.to_i * 1000
    body_params = {
  		:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  		:timestamp => timestamp, 
  		:username => ENV['username'],
      :placementIds => ENV['placement_id']
    }
    url_params = {}

  	response = Epom::Placement.get_placement_summary(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response.first
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of Array, first['category']
      assert_instance_of String, first['name']
      assert_instance_of String, first['key']
      assert_instance_of String, first['size']
      assert_instance_of Fixnum, first['zoneId']
    end
  end

  # TODO: create an stantard placement with CUSTOM_SITE_BANNER_SIZE
  test "create_standard_placement" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :zoneId => ENV['zone_id'],
      :type => Epom::PlacementType::SITE_PLACEMENT,
      :name => "placement #{timestamp}",
      :adUnit => Epom::AdUnitSize::CUSTOM_SITE_BANNER_SIZE,
      :height => 200,
      :width => 350,
    }
    url_params = {}

    response = Epom::Placement.create_standard_placement(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert response['success']
  end
end