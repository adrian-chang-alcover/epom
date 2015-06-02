require 'epom/epom_element'

module Epom
  class AdUnit < EpomElement

    def self.extended_methods
      {
          :get_ad_unit_list => {
              :url => '/rest-api/adunit/list.do',
              :body_parameters => [:hash, :timestamp, :username],
              :method => :get
            }
      }
    end

    def self.replace_params_in_url(url, url_params)
      url
    end

  end
end
