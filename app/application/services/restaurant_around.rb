# frozen_string_literal: true

require 'dry/transaction'
require 'json'

module THSRParking
  module Service
    # Transaction to store project from Github API to database
    class RestaurantAround
      include Dry::Transaction

      step :request_parks
      step :reify_list

      private

      def request_parks(input)
        Gateway::Api.new(THSRParking::App.config)
          .restaurants_info(input)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_list(restaurants_json)
        Representer::RestaurantsList.new(OpenStruct.new)
          .from_json(restaurants_json)
          .then { |restaurants| Success(restaurants) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
