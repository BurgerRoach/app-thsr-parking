# frozen_string_literal: true

require 'net/http'
require 'json'

module THSRParking
  module THSR
    # Library for THSR API
    class Api
      include Errors
      HTTP_ERROR = {
        400 => Errors::BadRequest,
        401 => Errors::Unauthorized,
        404 => Errors::NotFound
      }.freeze

      API_URL = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/ParkingAvailability/Rail/THSR?$format=JSON'

      def search(options = {}, mode = 'json')
        raise Errors::OptionsError if THSR::Options.new.invalid_options?(options)

        raw_data = call_api

        return JSON.parse(THSR::BaseMapper.new(raw_data, options).flatten.to_h.to_json) if mode == 'json'
        return THSR::BaseMapper.new(raw_data, options).flatten if mode == 'dry'
      end

      def search_by_city(city, options = {})
        # @params city {string} city name
        # @params options {hash}
        # @return {array-hash} the response data after filtered by city name
        filtered_data = search(options, 'dry')
        JSON.parse(THSR::City.new(filtered_data, city).get.to_h.to_json)
      end

      def search_by_park_id(park_id, options = {})
        # @params park_id {int} city name
        # @params options {hash}
        # @return {hash} the response data after filtered by park id
        filtered_data = search(options, 'dry')
        JSON.parse(THSR::Park.new(filtered_data, park_id).get.to_h.to_json)
      end

      private

      def call_api
        uri = URI(API_URL)
        response = Net::HTTP.get_response(uri)
        http_error?(response.code) ? JSON.parse(response.body) : raise(HTTP_ERROR[response.code])
      end

      def http_error?(status_code)
        HTTP_ERROR.keys.include?(status_code) ? false : true
      end
    end
  end
end
