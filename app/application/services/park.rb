# frozen_string_literal: true

require 'dry/monads'

module THSRParking
  module Service
    # Service of park
    class Park
      include Dry::Monads::Result::Mixin
      include Dry::Transaction

      # step :map_park
      step :request_results
      step :reify_results

      private

      # def map_park(city_name)
      #   city_map = {
      #     '桃園' => '1', '新竹' => '2', '苗栗' => '3', '台中' => '4', '彰化' => '5', '雲林' => '6', '嘉義' => '7', '台南' => '8', '高雄' => '9'
      #   }
      #   city_id = city_map[city_name]

      #   Success(city_id)
      # rescue StandardError
      #   Failure('City not found')
      # end

      def request_results(park_id)
        Gateway::Api.new(THSRParking::App.config)
          .one_park_info(park_id)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_results(parks_json)
        Representer::ParkResult.new(OpenStruct.new)
          .from_json(parks_json)
          .then do |result|
            Success(result)
          end
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
