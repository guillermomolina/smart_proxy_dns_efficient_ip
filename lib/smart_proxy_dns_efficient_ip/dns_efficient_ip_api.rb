require "resolv"

module Proxy::Dns::EfficientIp
  class Api
    attr_reader :connection
    attr_reader :logger

    def initialize(connection)
      @connection = connection
    end

    def find_zone(zone_name)
      result = connection.dns_zone_list(
        where: "dnszone_name='#{zone_name}' and dnszone_is_rpz='0' and dnszone_type='master'",
        limit: 1
      )
      parse(result.body)&.first
    end

    def find_zone_by_id(zone_id)
      result = connection.dns_zone_list(
        where: "dnszone_id='#{zone_id}'"
      )
      if result.code == 200
        parse(result.body)&.first
      else
        return []
      end
    end

    def zones
      result = connection.dns_zone_list(
        where: "dnszone_is_rpz='0' and dnszone_type='master'"
      )
      parse(result.body)
    end

    def create_record(zone, type, name, value)
      connection.dns_rr_add(
        dns_id: zone['dns_id'],
        rr_name: name,
        rr_type: type,
        value1: value
      )
    end

    def delete_record(zone, type, name)
      connection.dns_rr_delete(
        dns_id: zone['dns_id'],
        rr_name: name,
        rr_type: type
      )
    end

    private

    def parse(response)
      response.empty? ? nil : JSON.parse(response)
    end
  end
end
