require 'test_helper'
require 'SOLIDserver'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_main'

class ProviderTest < Test::Unit::TestCase
  def setup
    @connection = ::SOLIDserver::SOLIDserver.new('10.10.10.10', 'username', 'password')
    @api = ::Proxy::Dns::EfficientIp::Api.new(@connection)
    @record = ::Proxy::Dns::EfficientIp::Record.new(@api, nil)
  end

end
