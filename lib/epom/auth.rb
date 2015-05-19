require 'epom/epom_element'

module Epom
  class Auth < EpomElement

    def self.extended_methods
      {
          :get_authentication_token => {
              :url => '/rest-api/auth/token.do',
              :body_parameters => [:username, :password],
              :method => :post
          },
          :register_user => {
              :url => '/rest-api/register-user/KEY/HASH/TIMESTAMP.do',
              :url_parameters => [:key, :hash, :timestamp],
              :body_parameters => [:username, :password, :email, :role, :phone, :firstName, :lastName, :websiteUrl, :company, :country, :state, :enable_market_integration],
              :method => :post
          }
      }
    end

    def self.replace_params_in_url(url, url_params)
      url.gsub!('TOKEN', url_params[:token]) if url.include?('TOKEN')
      url.gsub!('KEY', url_params[:key]) if url.include?('KEY')
      url.gsub!('HASH', url_params[:hash]) if url.include?('HASH')
      url.gsub!('TIMESTAMP', url_params[:timestamp].to_s) if url.include?('TIMESTAMP')
      url
    end

  end
end
