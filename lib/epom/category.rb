require 'epom/epom_element'

module Epom
  class Category < EpomElement

		def self.extended_methods
			{
        :get_advertising_categories => {
            :url => '/rest-api/categories/advertising.do',
            :body_parameters => [:hash, :timestamp, :username],
            :method => :get
        },
        :get_publishing_categories => {
            :url => '/rest-api/categories/publishing.do',
            :body_parameters => [:hash, :timestamp, :username],
            :method => :get
        },        
			}
		end

    def self.replace_params_in_url(url, url_params)
      url
    end

  end
end
