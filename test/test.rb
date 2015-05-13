require 'pathname'
require 'yaml'

env_file = File.join(Pathname.new(__FILE__).parent.parent, 'config', 'application.yml')
YAML.load(File.open(env_file)).each do |key, value|
  ENV[key.to_s] = value.to_s
end if File.exists?(env_file)

require 'epom'

timestamp = Time.now.to_i * 1000
body_params = {
	:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
	:timestamp => timestamp, 
	:username => ENV['username'],
}
url_params = {}

response = Epom::Site.get_sites(url_params, body_params)

puts response
