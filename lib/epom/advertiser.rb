require 'epom/epom_element'

module Epom
  class Advertiser < EpomElement

    def self.extended_methods
      {
          :delete_advertiser => {
              :url => '/rest-api/advertisers/ADVERTISER_ID/delete.do',
              :url_parameters => [:advertiserId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :delete
          },
          :get_advertiser_permissions_for_user => {
              :url => '/rest-api/advertiserShares.do',
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
          },
          :get_campaigns_for_advertiser => {
              :url => '/rest-api/advertiser/ADVERTISER_ID/campaigns.do',
              :url_parameters => [:advertiserId],
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
          },
          :update_advertiser => {
              :url => '/rest-api/advertisers/update.do',
              :body_parameters => [:id, :name, :contactName, :contactEmail, :description, :categoryId, :hash, :timestamp, :username],
              :method => :put
          },
          :create_advertiser => {
              :url => '/rest-api/advertisers/update.do',
              :body_parameters => [:name, :contactName, :contactEmail, :description, :categoryId, :hash, :timestamp, :username],
              :method => :put
          },

      }
    end

    def self.replace_params_in_url(url, url_params)
      url.gsub!('ADVERTISER_ID', url_params[:advertiserId].to_s) if url.include?('ADVERTISER_ID')
      url
    end

  end
end
