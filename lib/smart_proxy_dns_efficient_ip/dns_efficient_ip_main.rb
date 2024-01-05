require 'dns/dns'
require 'dns_common/dns_common'
require 'smart_proxy_dns_efficient_ip/dns_efficient_ip_api'

module Proxy::Dns::EfficientIp
  class Record < ::Proxy::Dns::Record

    def initialize(api, ttl = nil)
      @api = api
      super('efficient_ip', ttl)
    end

    def do_create(name, value, type)
      logger.debug("Adding record (#{type}) #{name}=>#{value}")
      zone = match_zone(name)
      unless @api.create_record(zone, type, name, value)
        raise Proxy::Dns::Error.new("Failed to insert record (#{type}) #{name}=>#{value}")
      end
      true
    end

    def do_remove(name, type)
      logger.debug("Removing record (#{type}) #{name}")
      zone = match_zone(name)
      unless @api.delete_record(zone, type, name)
        raise Proxy::Dns::Error.new("Failed to remove record (#{type}) #{name}")
      end
      true
    end

    private

    def match_zone(record)
      weight = 0 # sub zones might be independent from similar named parent zones; use weight for longest suffix match
      matched_zone = nil
      @api.zones.each do |zone|
        zone_labels = zone[ "dnszone_name" ].downcase.split(".").reverse
        zone_weight = zone_labels.length
        fqdn_labels = record.downcase.split(".")
        fqdn_labels.shift
        is_match = zone_labels.all? { |zone_label| zone_label == fqdn_labels.pop }
        # match only the longest zone suffix
        if is_match && zone_weight >= weight
          matched_zone = zone
          weight = zone_weight
        end
      end
      raise Proxy::Dns::NotFound.new("The DNS server has no authoritative zone for #{record}") unless matched_zone
      matched_zone
    end
  end
end
