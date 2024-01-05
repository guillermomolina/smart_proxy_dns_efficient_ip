require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_version'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_configuration'

module Proxy::Dns::EfficientIp
  class Plugin < ::Proxy::Provider
    plugin :dns_efficient_ip, ::Proxy::Dns::EfficientIp::VERSION

    validate_presence :username, :password, :server_id

    requires :dns, '>= 1.15'

    load_classes ::Proxy::Dns::EfficientIp::Configuration
    load_dependency_injection_wirings ::Proxy::Dns::EfficientIp::Configuration
  end
end
