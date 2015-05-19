require 'test_helper'
require 'epom/campaign'

class CampaignTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Campaign
  end

  define_get_tests_auto(Epom::Campaign)

  test "get_actions" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.get_actions(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of String, first['key']
    end
  end  

  test "get_targetings" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.get_targetings(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Fixnum, first['id']
    end
  end  

  test "create_campaign" do
  	timestamp = Time.now.to_i * 1000
    body_params = {
  		:advertiserId => ENV['advertiser_id'], 
  		:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  		:timestamp => timestamp, 
  		:username => ENV['username'],
      :name => "campaign #{timestamp}",
      :description => "description for campaign #{timestamp}",
      :active => true}

  	response = Epom::Campaign.create_campaign({}, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_instance_of String, response['name']
  end  
end