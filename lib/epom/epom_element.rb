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

    def self.generic_method(method_name, url_params, body_params)
      signature = extended_parameters[method_name]
      url_params_signature = signature[:url_parameters]
      body_params_signature = signature[:body_parameters]
      url = replace_string_identifiers(url, params)
      
      valid = generic_validation(params, api_params)
      url = signature[:url]
      method = signature[:method]
      headers signature[:headers] if signature[:headers]

      if valid
        response = send(method, url, :query => params)
        if response.success?
          return response.parsed_response
        else
          response.code
        end
      else
        raise ArgumentError, 'Error in generic_validation method'
      end
    end

    def self.replace_params_in_url(url, url_params)
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