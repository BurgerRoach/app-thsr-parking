# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Transaction to store project from Github API to database
    class RestaurantAround
      include Dry::Transaction

      step :station_location
      step :find_restaruant

      private

      def station_location(input)
        result = THSRParking::Repository::Locations.find_park_by_id(input[:park_id])

        if result.nil?
          Failure("Error: Not found this park in database")
        else
          Success(lat: result.latitude,lng: result.longitude)
        end
      rescue StandardError => error
        puts error.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end

      def find_restaruant(input)
        api_key = ENV['API_KEY']
        radius = '500'
        type = 'restaurant'
        api = THSRParking::GoogleMap::Api.new(api_key)
        data = api.nearby_search(input[:lat], input[:lng], radius, type)
        if data.nil?
          input[:data] = nil
        else
          input[:data] = data
        end
        Success(input)
      rescue StandardError => error
        Failure(error.to_s)
      end
    end
  end
end