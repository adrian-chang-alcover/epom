module Epom
	class ConfigGenerator < Rails::Generators::NamedBase
	  source_root File.expand_path('../templates', __FILE__)

	  	def copy_config_file
	        template 'epom_config.rb', 'config/initializers/epom_config.rb'
	   	end
	end
end
