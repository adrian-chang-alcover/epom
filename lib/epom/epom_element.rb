module Epom
  class EpomElement

    include HTTMultiParty
      default_params :output => 'json'
      debug_output $stderr

    def self.login(username, password)
      @@username = username
      @@password = password
    end

    def self.extended_methods
      { }
    end

    def self.params_validation(params, params_signature)
      return true if params_signature.nil? or params_signature.count.zero?
      return true if params.keys.all? {|key| params_signature.include?(key.to_sym)}
      puts "invalid params: #{params.keys.select{|key| not params_signature.include?(key)}}"
      return false
    end

    def self.generic_method(method_name, url_params, body_params)
      signature = extended_methods[method_name]
      url_params_signature = signature[:url_parameters]
      body_params_signature = signature[:body_parameters]
      url_signature = signature[:url]   

      url_params.symbolize_keys! if url_params.is_a? Hash
      body_params.symbolize_keys! if body_params.is_a? Hash   
      
      url = replace_params_in_url(url_signature, url_params)
      method = signature[:method]

      if signature[:headers]
        headers signature[:headers]
      else
        default_options[:headers] = {}
      end

      if signature.has_key?(:format)
        format signature[:format]
      else
        format :json
      end

      timestamp = Time.now.to_i * 1000
      if body_params_signature.include?(:hash) and not body_params[:hash]
        body_params[:hash] = Epom.create_hash(Epom.create_hash(@@password), timestamp)
      end
      if body_params_signature.include?(:timestamp) and not body_params[:timestamp]
        body_params[:timestamp] = timestamp
      end
      if body_params_signature.include?(:username) and not body_params[:username]
        body_params[:username] = @@username
      end

      if params_validation(url_params, url_params_signature) and params_validation(body_params, body_params_signature)
        http_proxy ENV['proxy_address'], ENV['proxy_port'], ENV['proxy_user'], ENV['proxy_password']
        base_uri Epom.config.epom_server
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

    def self.respond_to?(method_name)
      return true if extended_methods.keys.include?(method_name.to_sym)
      super
    end
  end
end