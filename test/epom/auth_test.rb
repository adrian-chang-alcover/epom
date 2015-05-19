require 'test_helper'
require 'epom/auth'

class AuthTest < ActiveSupport::TestCase
  ACCOUNTS = [{:username => 'supervisor', :password => 'supervisor'},
              {:username => 'network', :password => 'network'},
              {:username => 'publisher', :password => 'publisher'},
              {:username => 'advertiser', :password => 'advertiser'},
              {:username => ENV['username'], :password => ENV['password']}]

  test "truth" do
    assert_kind_of Class, Epom::Auth
  end

  test "get authentication token" do
    ACCOUNTS.each do |account|
  	  response = Epom::Auth.get_authentication_token({}, account)
      assert_instance_of Hash, response
      assert response['success']
      assert_instance_of String, response['authToken']
    end  	
  end

  test "register user" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :key => ENV['public_key'],
      :hash => Epom.create_hash("advertiser_#{timestamp}", 'advertiser', "advertiser_#{timestamp}@gmail.com", ENV['private_key'], timestamp),
      :timestamp => timestamp
    }
    body_params = {      
      :username => "advertiser_#{timestamp}",
      :password => 'advertiser',
      :email => "advertiser_#{timestamp}@gmail.com",
      :role => 'ADVERTISER',
      :phone => '+22(345)7891012',
      :firstName => 'firstName',
      :lastName => 'lastName',
      :websiteUrl => 'http://www.qwe.com',
      :company => 'company',
      :country => 'US',
      :state => 'Florida',
      :enable_market_integration => true
    }

    response = Epom::Auth.register_user(url_params, body_params)
    assert_instance_of Hash, response
    assert response['success']
  end
end