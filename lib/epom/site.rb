require 'epom/epom_element'

module Epom
  class Site < EpomElement
    def self.extended_parameters
      {
          :delete_site => {
              :url => '/rest-api/sites/SITE_ID/delete.do',
              :parameters => [:siteId, :hash, :timestamp, :username ],
              :method => :post
          },
          :delete_site_cpm_threshold => {
              :url => '/rest-api/sites/SITE_ID/cpm-thresholds/delete.do',
              :parameters => [:siteId, :hash, :timestamp, :username ],
              :method => :post
          },
          :get_site_cpm_threshold_summary => {
              :url => '/rest-api/sites/SITE_ID/cpm-thresholds.do',
              :parameters => [:siteId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_site_pricing => {
              :url => '/rest-api/sites/SITE_ID/pricing.do',
              :parameters => [:siteId, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_sites => {
              :url => '/rest-api/sites.do',
              :parameters => [:publishingCategories, :hash, :timestamp, :username ],
              :method => :get
          },
          :get_sites_zones => {
              :url => '/rest-api/sites/SITE_ID/zones.do',
              :parameters => [:siteId, :hash, :timestamp, :username ],
              :method => :get
          },
          :set_site_cpm_thresholds => {
              :url => '/rest-api/sites/SITE_ID/cpm-thresholds.do',
              :parameters => [:siteId, :cpmThreshold, :siteCountryCPMThresholds, :hash, :timestamp, :username ],
              :method => :post
          },
          :set_site_pricing => {
              :url => '/rest-api/sites/SITE_ID/pricing.do?username=USERNAME&timestamp=TIMESTAMP&hash=HASH',
              :parameters => [:siteId, :paymentModel, :hash, :timestamp, :username, :revenueShare, :pricingType, :price ],
              :method => :post,
              :headers => {'Content-type' => 'application/json'}
          },
          :set_placement_pricing => {
              :url => '/rest-api/placements/PLACEMENT_ID/pricing.do',
              :parameters => [:placementId, :paymentModel, :hash, :timestamp, :username ],
              :method => :post
          },
          :update_site => {
              :url => '/rest-api/sites/update.do',
              :parameters => [:id, :createDefaultZone, :name, :url, :description, :email, :allowPlacementBannersLinkingChange, :categoryId, :revenueShare, :impressionsByMonth, :visitorsByMonth, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_site => {
              :url => '/rest-api/sites/update.do',
              :parameters => [:createDefaultZone, :name, :url, :description, :email, :allowPlacementBannersLinkingChange, :categoryId, :revenueShare, :impressionsByMonth, :visitorsByMonth, :hash, :timestamp, :username ],
              :method => :post
          },
      }
    end

    def self.replace_string_identifiers(url, params)
      url.gsub!('USERNAME', params[:username].to_s) if url.include?('USERNAME')
      url.gsub!('TIMESTAMP', params[:timestamp].to_s) if url.include?('TIMESTAMP')
      url.gsub!('HASH', params[:hash].to_s) if url.include?('HASH')
      url.gsub!('SITE_ID', params[:siteId].to_s) if url.include?('SITE_ID')
      url.gsub!('PLACEMENT_ID', params[:placementId].to_s) if url.include?('PLACEMENT_ID')
      url
    end
  end
end