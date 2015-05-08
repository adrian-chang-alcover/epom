module Epom
  class EpomElement

    include HTTMultiParty
      base_uri 'https://n29.epom.com/'
      default_params :output => 'json'
      format :json
      http_proxy ENV['proxy_address'], ENV['proxy_port'], ENV['proxy_user'], ENV['proxy_password']
      debug_output $stderr

    def self.extended_methods
      { }
    end

    def self.params_validation(params, params_signature)
      return true if params_signature.nil? or params_signature.count.zero?
      params.keys.all? {|key| params_signature.include?(key)}
    end

    def self.generic_method(method_name, url_params, body_params)
      signature = extended_methods[method_name]
      url_params_signature = signature[:url_parameters]
      body_params_signature = signature[:body_parameters]
      url_signature = signature[:url]      
      
      url = replace_params_in_url(url_signature, url_params)
      method = signature[:method]
      if signature[:headers]
        headers signature[:headers]
      else
        default_options[:headers] = {}
      end

      if params_validation(url_params, url_params_signature) and params_validation(body_params, body_params_signature)
        response = send(method, url, :query => body_params)
        if response.success?
          return response.parsed_response
        else
          response.code
        end
      else
        raise ArgumentError, 'Error in params_validation method'
      end
    end

    def self.replace_params_in_url(url, url_params)
      url
    end

    def self.method_missing(name, *args)
      if self.extended_methods.keys.include?(name.to_sym)
        self.generic_method(name, *args)
      else
        super
      end
    end
  end
end