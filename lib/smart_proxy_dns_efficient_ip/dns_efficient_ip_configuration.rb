module Proxy::Dns::EfficientIp
  class Configuration
    def load_classes
      require 'SOLIDserver'
      require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_api'
      require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_main'
    end

    def load_dependency_injection_wirings(container_instance, settings)
      container_instance.dependency :connection, (lambda do
        ::SOLIDserver::SOLIDserver.new(
          settings[:server_id],
          settings[:username],
          settings[:password],
          logger: ::Proxy::LogBuffer::Decorator.instance 
        )
      end)

      container_instance.dependency :api, (lambda do
        ::Proxy::Dns::EfficientIp::Api.new(
          container_instance.get_dependency(:connection)
        )
      end)

      container_instance.dependency :dns_provider, (lambda do
        ::Proxy::Dns::EfficientIp::Record.new(
          container_instance.get_dependency(:api),
          settings[:dns_ttl]
        )
      end)
    end
  end
end
