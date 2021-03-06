require 'epom/epom_element'
require 'epom/placement_type'
require 'epom/ad_unit_size'

module Epom
  class Placement < EpomElement
    
    def self.extended_methods
      {
          :delete_placement => {
              :url => '/rest-api/placements/PLACEMENT_ID/delete.do',
              :url_parameters => [:placementId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :post
          },
          :set_placement_pricing => {
              :url => '/rest-api/placements/PLACEMENT_ID/pricing.do?username=USERNAME&timestamp=TIMESTAMP&hash=HASH',
              :url_parameters => [:placementId, :hash, :timestamp, :username],
              :body_parameters => [],
              :method => :post,
              :headers => {'Content-type' => 'application/json'}
          },
          :get_placement_summary => {
              :url => '/rest-api/placements/summary.do',
              :body_parameters => [:placementIds, :publishingCategories, :hash, :timestamp, :username],
              :method => :get
          },
          :update_mobile_placement => {
              :url => '/rest-api/placements/update/mobile.do',
              :body_parameters => [:id, :zoneId, :type, :name, :description, :defaultCode, :hash, :timestamp, :username],
              :method => :post
          },
          :update_non_standard_placement => {
              :url => '/rest-api/placements/update/non-standard.do',
              :body_parameters => [:id, :zoneId, :type, :name, :description, :hash, :timestamp, :username],
              :method => :post
          },
          :create_non_standard_placement => {
              :url => '/rest-api/placements/update/non-standard.do',
              :body_parameters => [:zoneId, :type, :name, :description, :hash, :timestamp, :username],
              :method => :post
          },
          :update_standard_placement => {
              :url => '/rest-api/placements/update/standard.do',
              :body_parameters => [:id, :zoneId, :type, :name, :description, :adUnitId, :size, 'size.height'.to_sym, 'size.width'.to_sym, :allowVariableBannerSizes, :defaultCode, :rotateInterval, :hash, :timestamp, :username],
              :method => :post
          },
          :create_standard_placement => {
              :url => '/rest-api/placements/update/standard.do',
              :body_parameters => [:zoneId, :type, :name, :description, :adUnitId, :size, 'size.height'.to_sym, 'size.width'.to_sym, :allowVariableBannerSizes, :defaultCode, :rotateInterval, :hash, :timestamp, :username],
              :method => :post
          },
          :update_placement => {
              :url => '/rest-api/placements/update/standard.do',
              :body_parameters => [:id, :zoneId, :type, :name, :description, :adUnitId, :size, 'size.height'.to_sym, 'size.width'.to_sym, :allowVariableBannerSizes, :defaultCode, :rotateInterval, :hash, :timestamp, :username],
              :method => :post
          },
          :create_placement => {
              :url => '/rest-api/placements/update/standard.do',
              :body_parameters => [:zoneId, :type, :name, :description, :adUnitId, :size, 'size.height'.to_sym, 'size.width'.to_sym, :allowVariableBannerSizes, :defaultCode, :rotateInterval, :hash, :timestamp, :username],
              :method => :post
          }
      }
    end

    def self.replace_params_in_url(url, url_params)
      url.gsub!('USERNAME', url_params[:username].to_s) if url.include?('USERNAME')
      url.gsub!('TIMESTAMP', url_params[:timestamp].to_s) if url.include?('TIMESTAMP')
      url.gsub!('HASH', url_params[:hash].to_s) if url.include?('HASH')
      url.gsub!('PLACEMENT_ID', url_params[:placementId].to_s) if url.include?('PLACEMENT_ID')
      url
    end
  end
end