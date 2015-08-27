require 'test_helper'
require 'epom/advertiser'

class AdvertiserTest < ActiveSupport::TestCase
  Epom::EpomElement.login(ENV['username'], ENV['password'])

	test "truth" do
    assert_kind_of Class, Epom::Advertiser
  end

  test "delete_advertiser" do
    advertiser_id = test_create_advertiser()

    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :username => ENV['username']
    }
    url_params = {
      :advertiserId => advertiser_id
    }

  	response = Epom::Advertiser.delete_advertiser(url_params, body_params)
    assert_instance_of Hash, response
    assert response['success']
  end

  test "get_advertiser_permissions_for_user" do
  	timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
    }

  	response = Epom::Advertiser.get_advertiser_permissions_for_user({}, body_params)
    assert_instance_of Array, response
    if response.count > 0
    	first = response[0]
    	assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
      assert_instance_of String, first['shareType']
    end
  end

  test "get_campaigns_for_advertiser" do
  	timestamp = Time.now.to_i * 1000
    body_params = {
      :timestamp => timestamp, 
      :username => ENV['username']
    }
    url_params = {
      :advertiserId => ENV['advertiser_id'],       
    }

  	response = Epom::Advertiser.get_campaigns_for_advertiser(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
    	first = response[0]
    	assert_instance_of Hash, first
    	assert_instance_of Fixnum, first['id']
      assert_instance_of String, first['name']
    end
  end

  test "create advertiser" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :name => "advertiser #{DateTime.now}",
      :contactName => "advertiser contactName",
      :contactEmail => "advertiser@gmail.com",
      :description => "advertiser description"
    }

    response = Epom::Advertiser.create_advertiser({}, body_params)
    assert_instance_of Hash, response
    assert response['success']
    assert_instance_of Fixnum, response['id']
    response['id']
  end

  test "update_advertiser" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :id => ENV['advertiser_id'],
      :name => "advertiser #{DateTime.now}",
      :contactName => "advertiser contactName",
      :contactEmail => "advertiser@gmail.com",
      :description => "advertiser description"
    }

    response = Epom::Advertiser.update_advertiser({}, body_params)
    assert_instance_of Hash, response
    assert response['success']
    assert_instance_of Fixnum, response['id']
    response['id']
  end

  test "get_advertisers_tree" do
    timestamp = Time.now.to_i * 1000
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username']
    }
    url_params = {
    }

    response = Epom::Advertiser.get_advertisers_tree(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Fixnum, first['id']
      assert_instance_of Array, first['category']
      assert_instance_of String, first['name']
      assert_instance_of Array, first['campaigns']
    end
  end

  test "replace_params_in_url" do
    assert_equal "/rest-api/advertiser/#{ENV['advertiser_id']}/campaigns.do", Epom::Advertiser.replace_params_in_url('/rest-api/advertiser/ADVERTISER_ID/campaigns.do', {:advertiserId => ENV['advertiser_id']})
  end

  test 'garbage_collector' do
    if Epom.config.epom_server == 'https://n29.epom.com/'
      advertisers = Epom::Advertiser.get_advertiser_permissions_for_user({})
      advertisers.each do |advertiser|
        if advertiser['shareType'] == "Is Owner" and advertiser['id'] != ENV['advertiser_id'].to_i
          Epom::Advertiser.delete_advertiser({advertiserId: advertiser['id']})
        end
      end
    end
  end

  define_get_tests_auto(Epom::Advertiser)
end