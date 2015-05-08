require 'test_helper'
require 'epom/campaign'

class CampaignTest < ActiveSupport::TestCase
	test "truth" do
    assert_kind_of Class, Epom::Campaign
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