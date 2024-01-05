require 'test_helper'
require 'SOLIDserver'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_api'

class ApiTest < Test::Unit::TestCase
  def setup
    @connection = ::SOLIDserver::SOLIDserver.new('10.10.10.10', 'username', 'password')
    @api = ::Proxy::Dns::EfficientIp::Api.new(@connection)
  end

  def test_find_zone
    zone_name = 'test.local'
    zone = { 'dnszone_id' => '142', 'dnszone_type' => 'master' }
    server_response = stub(body: [zone].to_json)

    @connection
      .expects(:dns_zone_list)
      .with(where: "dnszone_name='#{zone_name}' and dnszone_is_reverse='0'", limit: 1)
      .returns(server_response)

    assert_equal @api.find_zone(zone_name), zone
  end

  def test_find_zones
    zones = [
      { 'dnszone_id' => '142', 'dnszone_type' => 'master' },
      { 'dnszone_id' => '182', 'dnszone_type' => 'master' },
      { 'dnszone_id' => '108', 'dnszone_type' => 'master' },
    ]
    server_response = stub(body: zones.to_json)

    @connection
      .expects(:dns_zone_list)
      .with(where: "dnszone_is_reverse='0'")
      .returns(server_response)

    assert_equal @api.zones, zones
  end
end
