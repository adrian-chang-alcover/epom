$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "epom/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "epom"
  s.version     = Epom::VERSION
  s.authors     = ["Pedro Quintero", "Adrian Chang", "Jorge Tomás"]
  s.email       = ["pecuerre@gmail.com", "adrian.chang.alcover@gmail.com", "jotolo7@gmail.com"]
  s.homepage    = "https://github.com/kewelta/epom"
  s.summary     = "Epom gem."
  s.description = "The Epom gem is a wrapper for Epom API in ruby."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'rails', '~> 4.2', '>= 4.2.0'
  s.add_runtime_dependency 'rake', '~> 10.4', '>= 10.4.2'
  s.add_runtime_dependency "httmultiparty", '~> 0.3', '>= 0.3.6'

  s.add_development_dependency "sqlite3", '~> 1.3', '>= 1.3.10'
  s.add_development_dependency "codeclimate-test-reporter", '~> 0.4', '>= 0.4.7'
  s.add_development_dependency 'byebug', '~> 4.0', '>= 4.0.3'
end
