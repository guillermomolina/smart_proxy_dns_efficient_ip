require 'smart_proxy_for_testing'
require 'json'
require 'SOLIDserver'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_api'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_main'

connection = ::SOLIDserver::SOLIDserver.new('192.168.170.56', 'username', 'password')
api = ::Proxy::Dns::EfficientIp::Api.new(connection)
provider = ::Proxy::Dns::EfficientIp::Record.new(api)

# zone_list = api.zones
# puts JSON.pretty_generate(zone_list)

# zone = api.find_zone("gestio.sys")
# puts JSON.pretty_generate(zone)

# zone = api.find_zone_by_id(1285)
# puts JSON.pretty_generate(zone)

# provider.do_create("test.gestio.sys", "192.168.170.17", "A")
# provider.do_remove("prueba.gestio.sys", "CNAME")
# puts JSON.pretty_generate(zone)

# provider.do_create("capsule-dns.gestio.sys", "ges-docker.gestio.sys", "CNAME")

rr = api.find_records("A", "ges-docker.gestio.sys")
puts JSON.pretty_generate(rr)

puts provider.record_conflicts_ip("ges-docker.gestio.sys", "A", "192.168.170.11")
puts provider.record_conflicts_ip("ges-docker.gestio.sys", "A", "192.168.170.18")
puts provider.record_conflicts_ip("ges-dockerXX.gestio.sys", "A", "192.168.170.11")
