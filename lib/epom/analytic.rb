require 'epom/epom_element'

module Epom
  class Analytic < EpomElement

    def self.extended_methods
      {
        :register_user => {
          :url => 'rest-api/analytics/FORMAT/LOGIN/HASH/TIMESTAMP.do',
          :url_parameters => [:format, :login, :hash, :timestamp],
          :body_parameters => [:customFrom, :customTo, :hourFrom, :hourTo, :groupRange, :displayIds, :statisticType, :range, :groupBy, :filterBy, :eqStr, :eqLong],
          :method => :get
        }
      }
    end

    def self.replace_params_in_url(url, url_params)
      url.gsub!('FORMAT', url_params[:format]) if url.include?('FORMAT')
      url.gsub!('LOGIN', url_params[:login]) if url.include?('LOGIN')
      url.gsub!('HASH', url_params[:hash]) if url.include?('HASH')
      url.gsub!('TIMESTAMP', url_params[:timestamp].to_s) if url.include?('TIMESTAMP')
      url
    end

  end
end