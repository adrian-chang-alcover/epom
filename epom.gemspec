$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "epom/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "epom"
  s.version     = Epom::VERSION
  s.authors     = ["Pedro Quintero", "Adrian Chang", "Jorge Tomás"]
  s.email       = ["pecuerre@gmail.com", "adrian.chang.alcover@gmail.com", "jotolo7@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Epom."
  s.description = "TODO: Description of Epom."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency 'rake'
  s.add_dependency "httmultiparty"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency 'byebug'
end
