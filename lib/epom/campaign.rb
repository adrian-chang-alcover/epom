require 'epom/epom_element'

module Epom
  class Campaign < EpomElement
    
    def self.extended_methods
      {
          :create_campaign => {
              :url => '/rest-api/campaign/create.do',
              :body_parameters => [:name, :advertiserId, :description, :active, :ctrOptimization, :weight, :allowNewPlacementsAutolinking, :autolinkCategories, :hash, :timestamp, :username ],
              :method => :post
          },
          :delete_campaign => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/delete.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :post
          },
          :get_banners_for_campaign => {
              :url => '/campaign/CAMPAIGN_ID/banners.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :update_campaign => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/update.do',
              :body_parameters => [:campaignId, :name, :advertiserId, :description, :active, :ctrOptimization, :weight, :allowNewPlacementsAutolinking, :autolinkCategories, :hash, :timestamp, :username ],
              :method => :post
          },

          ###########################
          # Campaign Capping API
          ###########################

          :get_action_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/actionCapping.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_click_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/clickCapping.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_frequency_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/frequencyCapping.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },

          :remove_action_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/actionCapping.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :delete
          },
          :remove_click_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/clickCapping.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :delete
          },
          :remove_frequency_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/frequencyCapping.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :delete
          },

          :set_action_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/actionCapping/set.do',
              :body_parameters => [:campaignId, :amount, :period, :periodType, :evenDistribution, :hash, :timestamp, :username ],
              :method => :post
          },
          :set_click_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/clickCapping/set.do',
              :body_parameters => [:campaignId, :amount, :period, :periodType, :evenDistribution, :hash, :timestamp, :username ],
              :method => :post
          },
          :set_frequency_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/frequencyCapping/set.do',
              :body_parameters => [:campaignId, :amount, :period, :periodType, :evenDistribution, :hash, :timestamp, :username ],
              :method => :post
          },

          :update_action_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/frequencyCapping/update.do',
              :body_parameters => [:campaignId, :amount, :period, :periodType, :evenDistribution, :hash, :timestamp, :username ],
              :method => :post
          },
          :update_click_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/clickCapping/update.do',
              :body_parameters => [:campaignId, :amount, :period, :periodType, :evenDistribution, :hash, :timestamp, :username ],
              :method => :post
          },
          :update_frequency_capping => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/frequencyCapping/update.do',
              :body_parameters => [:campaignId, :amount, :period, :periodType, :evenDistribution, :hash, :timestamp, :username ],
              :method => :post
          },

          ###########################
          # Campaign Limits API
          ###########################

          :disable_limits => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/limits.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :delete
          },
          :get_limits => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/limits.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :reset_limits => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/limits/reset.do',
              :body_parameters => [:campaignId, :limitCounters, :limitCounters, :hash, :timestamp, :username ],
              :method => :delete
          },
          :set_limits => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/limits/set.do',
              :body_parameters => [:campaignId, :totalImpressionsLimit, :totalClicksLimit, :totalBudgetLimit, :dailyImpressionsLimit, :dailyClicksLimit, :dailyBudgetLimit, :totalImpressions, :totalClicks, :totalBudget, :dailyImpressions, :dailyClicks, :dailyBudget, :startDate, :endDate, :totalImpressionsLimit, :totalClicksLimit, :totalBudgetLimit, :dailyImpressionsLimit, :dailyClicksLimit, :dailyBudgetLimit, :totalImpressions, :totalClicks, :totalBudget, :dailyImpressions, :dailyClicks, :dailyBudget, :hash, :timestamp, :username ],
              :method => :post
          },
          :update_limits => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/limits/update.do',
              :body_parameters => [:campaignId, :totalImpressionsLimit, :totalClicksLimit, :totalBudgetLimit, :dailyImpressionsLimit, :dailyClicksLimit, :dailyBudgetLimit, :totalImpressions, :totalClicks, :totalBudget, :dailyImpressions, :dailyClicks, :dailyBudget, :startDate, :endDate, :totalImpressionsLimit, :totalClicksLimit, :totalBudgetLimit, :dailyImpressionsLimit, :dailyClicksLimit, :dailyBudgetLimit, :totalImpressions, :totalClicks, :totalBudget, :dailyImpressions, :dailyClicks, :dailyBudget, :hash, :timestamp, :username ],
              :method => :post
          },


          ###########################
          # Campaign Targeting API
          ###########################

          :create_browser_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/browser/create.do',
              :body_parameters => [:campaignId, :browser, :relation, :browserVersion, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_channel_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/channel/create.do',
              :body_parameters => [:campaignId, :channel, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_cookie_value_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/cookie/create.do',
              :body_parameters => [:campaignId, :cookieName, :cookieValue, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_country_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/country/create.do',
              :body_parameters => [:campaignId, :countryCode, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_custom_parameter_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/custom/create.do',
              :body_parameters => [:campaignId, :expression, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_day_of_week_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/dayofweek/create.do',
              :body_parameters => [:campaignId, :dayOfWeek, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_device_format_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/deviceformat/create.do',
              :body_parameters => [:campaignId, :deviceFormat, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_device_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/device/create.do',
              :body_parameters => [:campaignId, :device, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_device_vendor_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/devicevendor/create.do',
              :body_parameters => [:campaignId, :deviceVendor, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_domain_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/domain/create.do',
              :body_parameters => [:campaignId, :domain, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_ip_range_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/iprange/create.do',
              :body_parameters => [:campaignId, :ipFrom, :ipTo, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_language_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/language/create.do',
              :body_parameters => [:campaignId, :languageCode, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_location_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/location/create.do',
              :body_parameters => [:campaignId, :countryCode, :regionName, :cityName, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_mobile_carrier_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/mobilecarrier/create.do',
              :body_parameters => [:campaignId, :mobileCarriers, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_os_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/os/create.do',
              :body_parameters => [:campaignId, :operatingSystem, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_screen_resolution_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/resolution/create.do',
              :body_parameters => [:campaignId, :relation, :screenWidth, :screenHeight, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_time_range_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/timerange/create.do',
              :body_parameters => [:campaignId, :timeFrom, :timeTo, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_wifi_traffic_target => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/wifi/create.do',
              :body_parameters => [:campaignId, :rule, :hash, :timestamp, :username ],
              :method => :post
          },
          :disable_targeting => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/disable.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :post
          },
          :enable_targeting => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/enable.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :post
          },

          :get_browsers => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/browsers/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_chrome_browsers => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/browsers/chrome/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_firefox_browsers => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/browsers/firefox/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_ie_browsers => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/browsers/ie/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_safari_browsers => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/browsers/safari/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },

          :get_country_regions => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/country/region/values.do',
              :body_parameters => [:campaignId, :countryCode, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_device_format_values => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/device/format/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_device_values => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/device/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_device_vendor_values => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/device/vendor/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_languages => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/language/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_mobile_carriers => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/mobilecarriers/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_os_values => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/os/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_os_versions_by_os_name => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/os/OS_NAME/versions.do',
              :body_parameters => [:campaignId, :osName, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_regions_cities => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/country/region/city/values.do',
              :body_parameters => [:campaignId, :countryCode, :regionName, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_screen_resolution_values => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/resolution/values.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_targeting => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/TARGET_ID.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_targetings => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targetings.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_targeting_types => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/types.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :remove_targeting => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/targeting/TARGET_ID/delete.do',
              :body_parameters => [:campaignId, :targetId, :hash, :timestamp, :username ],
              :method => :delete
          },

          ###########################
          # Campaign Adjusted CPM API
          ###########################

          :add_fixed_cpm_country_pricing => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/adjustedCpm/value.do',
              :body_parameters => [:campaignId, :value, :countryCode, :date, :hash, :timestamp, :username ],
              :method => :put
          },
          :adjusted_cpm_country_trigger => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/adjustedCpm/value.do',
              :body_parameters => [:campaignId, :enable, :hash, :timestamp, :username ],
              :method => :post
          },
          :adjusted_cpm_list => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/adjustedCpm/value.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },


          ###########################
          # Campaign Action Management API
          ###########################

          :create_action => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/action/create.do',
              :body_parameters => [:campaignId, :name, :clickToConversionTimeFrame, :clickToConversionTimeFramePeriodType, :viewToConversionTimeFrame, :viewToConversionTimeFramePeriodType, :hash, :timestamp, :username ],
              :method => :post
          },
          :get_action => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/action/ACTION_KEY.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_actions => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/actions.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :remove_action => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/action/ACTION_KEY/delete.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :delete
          },
          :update_action => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/action/ACTION_KEY/update.do',
              :body_parameters => [:campaignId, :name, :clickToConversionTimeFrame, :clickToConversionTimeFramePeriodType, :viewToConversionTimeFrame, :viewToConversionTimeFramePeriodType, :hash, :timestamp, :username ],
              :method => :post
          },
          :disable_campaign_country_pricing => {
              :url => '/rest-api/campaigns/CAMPAIGN_ID/pricing/COUNTRY_CODE.do',
              :body_parameters => [:campaignId, :countryCode, :hash, :timestamp, :username ],
              :method => :delete
          },
          :disable_campaign_pricing => {
              :url => '/rest-api/campaigns/CAMPAIGN_ID/pricing.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :delete
          },

          :get_campaign => {
              :url => '/rest-api/campaign/CAMPAIGN_ID.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_campaign_pricing => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/pricing.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_campaigns => {
              :url => '/rest-api/campaigns.do',
              :body_parameters => [:hash, :timestamp, :username ],
              :method => :get
          },
          :update_campaign_country_pricing => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/pricing/COUNTRY_CODE.do',
              :body_parameters => [:campaignId, :countryCode, :price, :hash, :timestamp, :username ],
              :method => :post
          },
          :update_campaign_country_pricing_batch => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/pricing/batch.do',
              :body_parameters => [:campaignId, :countryPrices, :hash, :timestamp, :username ],
              :method => :post
          },
          :update_campaign_pricing => {
              :url => '/rest-api/campaign/CAMPAIGN_ID/pricing.do',
              :body_parameters => [:campaignId, :hash, :timestamp, :username ],
              :method => :post
          },
      }
    end

    def self.replace_params_in_url(url, url_params)
      url.gsub!('CAMPAIGN_ID', url_params[:campaignId]) if url.include?('CAMPAIGN_ID')
      url.gsub!('OS_NAME', url_params[:osName]) if url.include?('OS_NAME')
      url.gsub!('TARGET_ID', url_params[:targetId]) if url.include?('TARGET_ID')
      url.gsub!('ACTION_KEY', url_params[:actionKey]) if url.include?('ACTION_KEY')
      url.gsub!('COUNTRY_CODE', url_params[:countryCode]) if url.include?('COUNTRY_CODE')
      url
    end

  end
end