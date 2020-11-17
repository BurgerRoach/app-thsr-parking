# frozen_string_literal: true

require 'net/http'
require 'json'

module THSRParking
  module GoogleMap
    # Library for Google Map API
    class Api
      include Errors
      HTTP_ERROR = {
        400 => Errors::BadRequest,
        401 => Errors::Unauthorized,
        404 => Errors::NotFound
      }.freeze

      API_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

      def initialize(api_key)
        @api_key = api_key
      end

      def nearby_search(lat, lng, radius, type)
        # @params lat {string} latitude
        # @params lng {string} longtitude
        # @params radius {string} search radius
        # @params type {string} type of location e.g. restaurant
        api_url = join_parameters(lat, lng, radius, type)
        raw_data = call_api(api_url)
        GoogleMap::Restaurant.new(raw_data).map
      end

      private

      def join_parameters(lat, lng, radius, type)
        "#{API_URL}?location=#{lat},#{lng}&radius=#{radius}&type=#{type}&key=#{@api_key}"
      end

      def call_api(api_url)
        uri = URI(api_url)
        response = Net::HTTP.get_response(uri)
        http_error?(response.code) ? JSON.parse(response.body) : raise(HTTP_ERROR[response.code])
      end

      def http_error?(status_code)
        HTTP_ERROR.keys.include?(status_code) ? false : true
      end
    end
  end
end
