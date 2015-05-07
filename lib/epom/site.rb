require 'epom/epom_element'

module Epom
  class Site < EpomElement
    def self.extended_parameters
      {
          :delete_site => {
              :url => '/rest-api/sites/SITE_ID/delete.do',
              :url_parameters => [:siteId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :post
          },
          :delete_site_cpm_threshold => {
              :url => '/rest-api/sites/SITE_ID/cpm-thresholds/delete.do',
              :url_parameters => [:siteId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :post
          },
          :get_site_cpm_threshold_summary => {
              :url => '/rest-api/sites/SITE_ID/cpm-thresholds.do',
              :url_parameters => [:siteId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
          },
          :get_site_pricing => {
              :url => '/rest-api/sites/SITE_ID/pricing.do',
              :url_parameters => [:siteId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
          },
          :get_sites => {
              :url => '/rest-api/sites.do',
              :body_parameters => [:publishingCategories, :hash, :timestamp, :username],
              :method => :get
          },
          :get_sites_zones => {
              :url => '/rest-api/sites/SITE_ID/zones.do',
              :url_parameters => [:siteId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
          },
          :set_site_cpm_thresholds => {
              :url => '/rest-api/sites/SITE_ID/cpm-thresholds.do',
              :url_parameters => [:siteId],
              :body_parameters => [:cpmThreshold, :siteCountryCPMThresholds, :hash, :timestamp, :username],
              :method => :post
          },
          :set_site_pricing => {
              :url => '/rest-api/sites/SITE_ID/pricing.do?username=USERNAME&timestamp=TIMESTAMP&hash=HASH',
              :url_parameters => [:siteId, :hash, :timestamp, :username],
              :body_parameters => [],
              :method => :post,
              :headers => {'Content-type' => 'application/json'}
          },
          :set_placement_pricing => {
              :url => '/rest-api/placements/PLACEMENT_ID/pricing.do',
              :url_parameters => [:placementId],
              :body_parameters => [],
              :method => :post
          },
          :update_site => {
              :url => '/rest-api/sites/update.do',
              :body_parameters => [:id, :createDefaultZone, :name, :url, :description, :email, :allowPlacementBannersLinkingChange, :categoryId, :revenueShare, :impressionsByMonth, :visitorsByMonth, :hash, :timestamp, :username ],
              :method => :post
          },
          :create_site => {
              :url => '/rest-api/sites/update.do',
              :body_parameters => [:createDefaultZone, :name, :url, :description, :email, :allowPlacementBannersLinkingChange, :categoryId, :revenueShare, :impressionsByMonth, :visitorsByMonth, :hash, :timestamp, :username ],
              :method => :post
          },
      }
    end

    def self.replace_params_in_url(url, url_params)
      url.gsub!('USERNAME', url_params[:username].to_s) if url.include?('USERNAME')
      url.gsub!('TIMESTAMP', url_params[:timestamp].to_s) if url.include?('TIMESTAMP')
      url.gsub!('HASH', url_params[:hash].to_s) if url.include?('HASH')
      url.gsub!('SITE_ID', url_params[:siteId].to_s) if url.include?('SITE_ID')
      url.gsub!('PLACEMENT_ID', url_params[:placementId].to_s) if url.include?('PLACEMENT_ID')
      url
    end
  end
end