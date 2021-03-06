# frozen_string_literal: true

require 'dry/monads'

module THSRParking
  module Service
    # Service of park
    class Parks
      include Dry::Monads::Result::Mixin
      include Dry::Transaction

      step :map_park
      step :request_results
      step :reify_results

      private

      def map_park(city_name)
        city_map = {
          '桃園' => '1', '新竹' => '2', '苗栗' => '3', '台中' => '4', '彰化' => '5', '雲林' => '6', '嘉義' => '7', '台南' => '8', '高雄' => '9'

          # '桃園' => '1020','新竹' => '1030','苗栗' => '1035','台中' => '1040','彰化' => '1043','雲林' => '1047', '嘉義' => '1050', '台南' => '1060', '高雄' => '1070'
        }
        city_id = city_map[city_name]

        Success(city_id)
      rescue StandardError
        Failure('City not found')
      end

      def request_results(input)
        Gateway::Api.new(THSRParking::App.config)
          .park_info(input)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_results(parks_json)
        Representer::ParksList.new(OpenStruct.new)
          .from_json(parks_json)
          .then { |parks| Success(parks['parks']) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
