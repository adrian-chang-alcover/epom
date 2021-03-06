# epom

[![Build Status](https://semaphoreci.com/api/v1/projects/fbca0f2d-ea53-428e-a910-3050d1c2af78/360534/shields_badge.svg)](https://semaphoreci.com/cmgver/epom)
[![Code Climate](https://codeclimate.com/repos/54eb90386956804fe6003401/badges/7a524fd655323e4dcd8f/gpa.svg)](https://codeclimate.com/repos/54eb90386956804fe6003401/feed)
[![Test Coverage](https://codeclimate.com/repos/54eb90386956804fe6003401/badges/7a524fd655323e4dcd8f/coverage.svg)](https://codeclimate.com/repos/54eb90386956804fe6003401/coverage)

The Epom gem is a wrapper for Epom API in Ruby.


## Install

Put this line in your Gemfile:

`gem 'epom'`

The bundle:

`$ bundle`

There's a handy generator that generates the default configuration file into config/initializers directory.
Run the following generator command, then edit the generated file.
`$ rails generate epom:config`


## Usage

The following example creates a new user with role ADVERTISER:
 ```
timestamp = Time.now.to_i * 1000
url_params = {
  :key => ENV['public_key'],
  :hash => Epom.create_hash("advertiser_#{timestamp}", 'advertiser', "advertiser_#{timestamp}@gmail.com", ENV['private_key'], timestamp),
  :timestamp => timestamp
}
body_params = {      
  :username => "advertiser_#{timestamp}",
  :password => 'advertiser',
  :email => "advertiser_#{timestamp}@gmail.com",
  :role => 'ADVERTISER',
  :phone => '+22(345)7891012',
  :firstName => 'firstName',
  :lastName => 'lastName',
  :websiteUrl => 'http://www.qwe.com',
  :company => 'company',
  :country => 'US',
  :state => 'Florida',
  :enable_market_integration => true
}

response = Epom::Auth.register_user(url_params, body_params)
# or response = Epom::Auth.register_user(url_params.merge(body_params))
 ```

 The following example list all sites that belongs to a specific user:
 ```
timestamp = Time.now.to_i * 1000
body_params = {
	:hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
	:timestamp => timestamp, 
	:username => ENV['username'],
}

response = Epom::Site.get_sites(body_params)
```

The following example set the price of a specific site:
```
timestamp = Time.now.to_i * 1000
url_params = {
  :hash => Epom.create_hash(Epom.create_hash(ENV['password']), timestamp),
  :timestamp => timestamp, 
  :username => ENV['username'],
  :siteId => ENV['site_id']
}
body_params = '{"paymentModel":"FIXED_PRICE","pricingType":"CPM","price":4.2}'

response = Epom::Site.set_site_pricing(url_params, body_params)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/epom/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request