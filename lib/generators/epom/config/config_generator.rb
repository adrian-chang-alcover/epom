module Epom
	class ConfigGenerator < Rails::Generators::Base
	  source_root File.expand_path('../templates', __FILE__)

	  	def copy_epom_file
	        template 'epom.rb', 'config/initializers/epom.rb'
	   	end
	end
end
