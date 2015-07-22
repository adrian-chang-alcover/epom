module Epom
	class ConfigGenerator < Rails::Generators::Base
	  source_root File.expand_path('../templates', __FILE__)

	  	def copy_epom_file
	        template 'epom.rb', 'config/initializers/epom.rb'
	        if File.exist?('.gitignore')
	        	File.open('.gitignore','a'){|f| f.write("\nconfig/initializers/epom.rb")}
	        end
	        if File.exist?('../../.gitignore')
	        	File.open('../../.gitignore','a'){|f| f.write("\ntest/dummy/config/initializers/epom.rb")}
	        end
	    end
	end
end
