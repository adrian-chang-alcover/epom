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

  test "update_campaign" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id']
    }
    body_params = {
      :advertiserId => ENV['advertiser_id'], 
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :name => "campaign #{timestamp}",
      :description => "description for campaign #{timestamp}",
      :active => true}

    response = Epom::Campaign.update_campaign(url_params, body_params)
    assert_instance_of Hash, response
    assert response['success']

    campaign = test_get_campaign()
    assert_instance_of Hash, campaign
    assert_equal ENV['campaign_id'], campaign['id'].to_s
    assert_equal "campaign #{timestamp}", campaign['name']
  end  

  test "get_click_capping" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.get_click_capping(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Hash, first
      assert_instance_of Fixnum, first['id']
      assert_instance_of Fixnum, first['amount']
      assert_instance_of String, first['periodType']
      assert_instance_of Fixnum, first['period']
    end  
    response
  end  

  test "set_click_capping" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :amount => [1,2,3,4,5,6,7].sample,
      :evenDistribution => true,
      :periodType => 'HOUR',
      :period => 2
    }

    response = Epom::Campaign.set_click_capping(url_params, body_params)

    click_cappings = test_get_click_capping()
    click_capping = click_cappings.find { |cc| cc['amount'] == body_params[:amount] }
    assert_instance_of Hash, click_capping
    assert_instance_of Fixnum, click_capping['id']
    assert_equal true, click_capping['evenDistribution']
    assert_equal 'HOUR', click_capping['periodType']
    assert_equal 2, click_capping['period']
  end  

  test "get_limits" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.get_limits(url_params, body_params)
    assert_instance_of Hash, response
    response
  end  

  test "set_limits" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :totalImpressionsLimit => 100, 
      :dailyImpressionsLimit => 20,
      :totalClicksLimit => 50,
      :dailyClicksLimit => 10,
      :totalBudgetLimit => 50,
      :dailyBudgetLimit => 10, 
      :startDate => DateTime.now.strftime('%Y-%m-%d-%H-%M'), 
      :endDate => Date.tomorrow.strftime('%Y-%m-%d-%H-%M'),
    }

    response = Epom::Campaign.set_limits(url_params, body_params)

    limit = test_get_limits()
    assert_instance_of Hash, limit
    assert_equal body_params[:totalImpressionsLimit], limit['totalImpressionsLimit']
    assert_equal body_params[:dailyImpressionsLimit], limit['dailyImpressionsLimit']
    assert_equal body_params[:totalClicksLimit], limit['totalClicksLimit']
    assert_equal body_params[:dailyClicksLimit], limit['dailyClicksLimit']
    assert_equal body_params[:totalBudgetLimit], limit['totalBudgetLimit']
    assert_equal body_params[:dailyBudgetLimit], limit['dailyBudgetLimit']
    assert_equal body_params[:startDate], limit['startDate']
    assert_equal body_params[:endDate], limit['endDate']
  end  

  test "create_cookie_value_target" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :cookieName => 'age',
      :cookieValue => '20',
      :rule => 'INCLUDE'
    }

    response = Epom::Campaign.create_cookie_value_target(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_equal body_params[:cookieName], response['cookieName']
    assert_equal body_params[:cookieValue], response['cookieValue']
  end  

  test "create_country_target" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :countryCode => ENV['country_code'],
      :rule => 'INCLUDE'
    }

    response = Epom::Campaign.create_country_target(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_equal 'COUNTRY', response['type']
  end  

  test "create_custom_parameter_target" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :expression => "($p1==1 || $p1=='a') && ($p2>=12 && $p2<=22)",
      :rule => 'INCLUDE'
    }

    response = Epom::Campaign.create_custom_parameter_target(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_equal 'CUSTOM', response['type']
  end  

  test "create_language_target" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :languageCode => 'en',
      :rule => 'INCLUDE'
    }

    response = Epom::Campaign.create_language_target(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_equal 'LANGUAGE', response['type']
  end  

  test "disable_targeting" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.disable_targeting(url_params, body_params)
    assert_not_instance_of Fixnum, response
  end  

  test "enable_targeting" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.enable_targeting(url_params, body_params)
    assert_not_instance_of Fixnum, response
  end  

  test "get_targeting" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
      :targetId => '3929'
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.get_targeting(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
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

  test "get_campaign" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
      
    response = Epom::Campaign.get_campaign(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_instance_of String, response['name']
    response
  end

  ##########################
  ## Campaign Adjusted CPM API
  ##########################

  test "add_fixed_cpm_country_pricing" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :countryCode => ENV['country_code'],
      :value => '2.5',
      :date => DateTime.now.strftime('%Y-%m-%d-%H-%M')
    }
      
    response = Epom::Campaign.add_fixed_cpm_country_pricing(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert response['success']
  end

  test "adjusted_cpm_list" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }
      
    response = Epom::Campaign.adjusted_cpm_list(url_params, body_params)
    assert_instance_of Array, response
    if response.count > 0
      first = response[0]
      assert_instance_of Fixnum, first['id']
      assert_instance_of Float, first['value']
      assert_instance_of String, first['country']
    end
  end

  ##########################
  ## Campaign Action Management API
  ##########################

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

  test "get_campaign_pricing" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Campaign.get_campaign_pricing(url_params, body_params)
    assert_instance_of Hash, response
    assert_instance_of Fixnum, response['id']
    assert_instance_of String, response['paymentModel']
    response
  end  

  test "update_campaign_country_pricing" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
      :countryCode => ENV['country_code']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :price => [1.1, 2.3, 3.1].sample
    }

    response = Epom::Campaign.update_campaign_country_pricing(url_params, body_params)
    assert_not_instance_of Fixnum, response
  end  

  test "update_campaign_pricing" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :campaignId => ENV['campaign_id'],
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
      :price => 2.9
    }

    response = Epom::Campaign.update_campaign_pricing(url_params, body_params)
    assert_not_instance_of Fixnum, response

    pricing = test_get_campaign_pricing()
    assert_equal 2.9, body_params[:price]
  end  

  define_get_tests_auto(Epom::Campaign)
end