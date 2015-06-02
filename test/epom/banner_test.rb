require 'test_helper'
require 'epom/banner'

class BannerTest < ActiveSupport::TestCase
	# test "truth" do
 #    assert_kind_of Class, Epom::Banner
 #  end

 #  #TODO: create banner with LOCAL_FILE
 #  test "create_banner" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :campaignId => ENV['campaign_id'], 
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :weight => 1,
 #      :imageBannerLink => "http://beachgrooves.com/wp-content/uploads/2014/07/BeachGrooves-Logos-website2.png",
 #      :url => "http://www.example.com",
 #      :name => "banner #{timestamp}",
 #      :bannerType => Epom::BannerType::EXTERNAL_FILE,
 #      :adUnitId => 10,
 #      :active => '1',
 #      :placementType => Epom::PlacementType::SITE_PLACEMENT,
 #      :adUnitWidth => 237,#128
 #      :adUnitHeight => 100,#114
 #      # :imageFile => File.new('test/IMG_5457-128x128.JPG')
 #    }

 #    response = Epom::Banner.create_banner({}, body_params)
 #    assert_instance_of Hash, response
 #    assert_instance_of Fixnum, response['id']
 #    assert_instance_of Fixnum, response['campaignId']
 #    assert_equal ENV['campaign_id'].to_i, response['campaignId']
 #  end

 #  test "get_os_values" do
 #    timestamp = Time.now.to_i * 1000
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }

 #    response = Epom::Banner.get_os_values(url_params, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of String, first
 #    end
 #  end

 #  test "get_banner_ad_unit_values" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :placementType => Epom::PlacementType::SITE_PLACEMENT
 #    }

 #    response = Epom::Banner.get_banner_ad_unit_values({}, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response.first
 #      assert_instance_of Fixnum, first['id']
 #      assert_instance_of Fixnum, first['height']
 #      assert_instance_of Fixnum, first['width']
 #      assert_instance_of String, first['name']
 #    end
 #  end  

 #  test "get_banner_pricing" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }

 #    response = Epom::Banner.get_banner_pricing(url_params, body_params)
 #    assert_instance_of Hash, response
 #    assert_instance_of Fixnum, response['id']
 #    assert_instance_of String, response['paymentModel']
 #  end

 #  test "get_placements_for_banner" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }

 #    response = Epom::Banner.get_placements_for_banner(url_params, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of Hash, first
 #      assert_instance_of Fixnum, first['id']
 #      assert_instance_of String, first['name']
 #    end
 #  end

 #  test "get_targetings" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }

 #    response = Epom::Banner.get_targetings(url_params, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of Hash, first
 #      assert_instance_of Fixnum, first['id']
 #      assert_instance_of String, first['rule']
 #      assert_instance_of String, first['type']
 #    end
 #  end

 #  test "get_advertising_categories" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }

 #    response = Epom::Banner.get_advertising_categories({}, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of Hash, first
 #      assert_instance_of Fixnum, first['id']
 #      assert_instance_of String, first['name']
 #    end
 #  end

 #  test "get_banner" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }

 #    response = Epom::Banner.get_banner(url_params, body_params)
 #    assert_instance_of Hash, response
 #    assert_instance_of Fixnum, response['campaignId']
 #    assert_instance_of String, response['url']
 #    assert_instance_of String, response['name']
 #    assert_instance_of String, response['bannerType']
 #    assert_instance_of Fixnum, response['adUnitId']
 #    assert_instance_of String, response['placementType']
 #  end

 #  test "get_publishing_categories" do
 #    timestamp = Time.now.to_i * 1000
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }

 #    response = Epom::Banner.get_publishing_categories({}, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of Hash, first
 #      assert_instance_of Fixnum, first['id']
 #      assert_instance_of String, first['name']
 #    end
 #  end

 #  #######################
 #  #Banner Capping API
 #  #######################

 #  test "get_click_capping" do
 #    timestamp = Time.now.to_i * 1000
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }

 #    response = Epom::Banner.get_click_capping(url_params, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of Fixnum, first['amount']
 #      assert_instance_of String, first['periodType']
 #      assert_instance_of Fixnum, first['period']
 #    end  
 #    response
 #  end

 #  test "get_frequency_capping" do
 #    timestamp = Time.now.to_i * 1000
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #    }

 #    response = Epom::Banner.get_frequency_capping(url_params, body_params)
 #    assert_instance_of Array, response
 #    if response.count > 0
 #      first = response[0]
 #      assert_instance_of Fixnum, first['amount']
 #      assert_instance_of String, first['periodType']
 #      assert_instance_of Fixnum, first['period']
 #    end  
 #    response
 #  end

 #  test "set_click_capping" do
 #    timestamp = Time.now.to_i * 1000
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :amount => [1,2,3,4,5,6,7].sample,
 #      :evenDistribution => true,
 #      :periodType => 'HOUR',
 #      :period => 2
 #    }

 #    response = Epom::Banner.set_click_capping(url_params, body_params)

 #    click_cappings = test_get_click_capping()
 #    click_capping = click_cappings.find { |cc| cc['amount'] == body_params[:amount] }
 #    assert_instance_of Hash, click_capping
 #    assert_equal true, click_capping['evenDistribution']
 #    assert_equal 'HOUR', click_capping['periodType']
 #    assert_equal 2, click_capping['period']
 #  end  

 #  test "set_frequency_capping" do
 #    timestamp = Time.now.to_i * 1000
 #    url_params = {
 #      :bannerId => ENV['banner_id']
 #    }
 #    body_params = {
 #      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
 #      :timestamp => timestamp, 
 #      :username => ENV['username'],
 #      :amount => [1,2,3,4,5,6,7].sample,
 #      :evenDistribution => true,
 #      :periodType => 'HOUR',
 #      :period => 2
 #    }

 #    response = Epom::Banner.set_frequency_capping(url_params, body_params)

 #    frequency_cappings = test_get_frequency_capping()
 #    frequency_capping = frequency_cappings.find { |cc| cc['amount'] == body_params[:amount] }
 #    assert_instance_of Hash, frequency_capping
 #    assert_equal true, frequency_capping['evenDistribution']
 #    assert_equal 'HOUR', frequency_capping['periodType']
 #    assert_equal 2, frequency_capping['period']
 #  end  

  # #######################
  # #Banner Limits API
  # #######################

  test "get_limits" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :bannerId => ENV['banner_id']
    }
    body_params = {
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
      :timestamp => timestamp, 
      :username => ENV['username'],
    }

    response = Epom::Banner.get_limits(url_params, body_params)
    assert_instance_of Hash, response
    response
  end

  test "set_limits" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :bannerId => ENV['banner_id'],
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

    response = Epom::Banner.set_limits(url_params, body_params)

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

 #  define_get_tests_auto(Epom::Banner)
end