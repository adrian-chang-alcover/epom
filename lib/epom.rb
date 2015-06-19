require 'httmultiparty'
require 'digest'

require 'epom/ad_unit'
require 'epom/advertiser'
require 'epom/auth'
require 'epom/banner'
require 'epom/campaign'
require 'epom/category'
require 'epom/epom_element'
require 'epom/placement'
require 'epom/publisher'
require 'epom/site'
require 'epom/zone'

require 'epom/config'

module Epom

  def self.create_hash(*args)
  	md5 = Digest::MD5.new
    md5 << args.join
  	md5.hexdigest
  end

end
