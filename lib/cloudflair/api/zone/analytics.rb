require 'cloudflair/entity'

module Cloudflair
  class Analytics
    attr_reader :zone_identifier

    include Cloudflair::Entity
    path 'zones/:zone_identifier/analytics'

    def initialize(zone_identifier)
      @zone_identifier = zone_identifier
    end

    def dashboard(filter={})
      raw_response = connection.get "#{path}/dashboard", filter
      parsed_response = response raw_response
      hash_to_object parsed_response
    end

    def colos(filter={})
      raw_response = connection.get "#{path}/colos", filter
      parsed_responses = response raw_response
      parsed_responses.map do |parsed_response|
        hash_to_object parsed_response
      end
    end
  end
end
