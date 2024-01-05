require 'test_helper'
require 'SOLIDserver'
require 'dns_common/dns_common'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_api'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_main'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_configuration'

class ConfigurationTest < Test::Unit::TestCase
  def setup
    @settings = {
      username: 'username',
      password: 'password',
      server_ip: '10.10.10.10'
    }
    @container = ::Proxy::DependencyInjection::Container.new
    Proxy::Dns::EfficientIp::Configuration.new.load_dependency_injection_wirings(@container, @settings)
  end

  def test_connection
    connection = @container.get_dependency(:connection)

    assert_instance_of ::SOLIDserver::SOLIDserver, connection
  end

  def test_api
    api = @container.get_dependency(:api)

    assert_instance_of ::Proxy::Dns::EfficientIp::Api, api
  end

  def test_provider
    provider = @container.get_dependency(:dns_provider)

    assert_instance_of ::Proxy::Dns::EfficientIp::Record, provider
  end
end
