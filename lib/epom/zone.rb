require 'epom/epom_element'

module Epom
  class Zone < EpomElement

    def self.extended_methods
      {
          :delete_zone => {
              :url => '/rest-api/zones/ZONE_ID/delete.do',
              :url_parameters => [:zoneId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :post
          },
          :get_zone_placements => {
              :url => '/rest-api/zones/ZONE_ID/placements.do',
              :url_parameters => [:zoneId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
          },
          :update_zone => {
              :url => '/rest-api/zones/update.do',
              :body_parameters => [:zoneId, :siteId, :description, :name, :hash, :timestamp, :username],
              :method => :post
          },
          :create_zone => {
              :url => '/rest-api/zones/update.do',
              :body_parameters => [:siteId, :description, :name, :hash, :timestamp, :username],
              :method => :post
          }
      }
    end

    def self.replace_params_in_url(url, url_params)
       url.gsub!('ZONE_ID', url_params[:zoneId].to_s) if url.include?('ZONE_ID')
       url
    end
  end
end