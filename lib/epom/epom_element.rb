module Epom
  class EpomElement

    include HTTMultiParty
      base_uri 'https://n29.epom.com/'
      default_params :output => 'json'
      format :json
      http_proxy ENV['proxy_address'], ENV['proxy_port'], ENV['proxy_user'], ENV['proxy_password']
      debug_output $stderr

    def self.extended_parameters
      { }
    end

    def self.generic_validation(params, api_params)
      params.keys.all? {|key| api_params.include?(key)}
    end

    def self.generic_method(method_name, params)
      hash = extended_parameters[method_name]
      url = hash[:url]
      api_params = hash[:parameters]
      url = replace_string_identifiers(url, params)
      
      valid = generic_validation(params, api_params)
      method = hash[:method]
      headers hash[:headers] if hash[:headers]

      if valid
        response = send(method, url, :query => '{"paymentModel":"FIXED_PRICE","pricingType":"CPM","price":3.5}')
        if response.success?
          return response.parsed_response
        else
          response.code
        end
      else
        raise ArgumentError, 'Error in generic_validation method'
      end
    end

    def self.replace_string_identifiers(url, params)
      url
    end

    def self.method_missing(name, *args)
      if self.extended_parameters.keys.include?(name.to_sym)
        self.generic_method(name, args[0])
      else
        super
      end
    end
  end
end