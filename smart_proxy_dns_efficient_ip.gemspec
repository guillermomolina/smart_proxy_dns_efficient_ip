require File.expand_path('../lib/smart_proxy_dns_efficient_ip/dns_efficient_ip_version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'smart_proxy_dns_efficient_ip'
  s.version     = Proxy::Dns::EfficientIp::VERSION
  s.date        = Date.today.to_s
  s.license     = 'GPL-3.0'
  s.authors     = ['Guillermo Adrián Molina']
  s.email       = ['guillermoadrianmolina@hotmail.com']

  s.homepage    = 'https://github.com/guillermomolina/smart_proxy_dns_efficient_ip'
  s.summary     = "Smart proxy plugin for EfficientIP"
  s.description = "Plugin for integration Foreman's smart proxy Dns with EfficientIP"

  s.files       = Dir['{config,lib,bundler.d}/**/*'] + ['README.md', 'LICENSE']
  s.test_files  = Dir['test/**/*']

  s.add_runtime_dependency('SOLIDserver', '~> 0.0.12')

  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('mocha', '~> 1.11')
  s.add_development_dependency('test-unit', '~> 3.4')
end
