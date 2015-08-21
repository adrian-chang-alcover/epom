require 'test_helper'
require 'epom/analytic'

class AnalyticTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, Epom::Analytic
  end

  test "analytics" do
    timestamp = Time.now.to_i * 1000
    url_params = {
      :format => 'CSV',
      :login => ENV['username'],
      :timestamp => timestamp,
      :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp)
    }
    body_params = {    
      :displayIds => true,
      :range => 'CURRENT_MONTH',
      :groupBy => 'ADVERTISER,CAMPAIGN,BANNER,SITE,ZONE,PLACEMENT,CHANNEL,COUNTRY',
      # :groupRange => 'HOUR',
      :eqLong => {'ADVERTISER' => 1252, 'SITE' => 1059}
    }

    response = Epom::Analytic.analytics(url_params, body_params)
    assert_not_instance_of Fixnum, response
  end
end