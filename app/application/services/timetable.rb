# frozen_string_literal: true

require 'dry/monads'

module THSRParking
  module Service
    # Service of park
    class Timetable
      include Dry::Monads::Result::Mixin
      include Dry::Transaction

      step :map_park
      step :request_results
      step :reify_results

      private

      def map_park(input)
        city_map = {
          '桃園' => '1020','新竹' => '1030','苗栗' => '1035','台中' => '1040','彰化' => '1043','雲林' => '1047', '嘉義' => '1050', '台南' => '1060', '高雄' => '1070'
        }
        input[:station_id] = city_map[input[:city_name]]
        Success(input)
      rescue StandardError
        Failure('City not found')
      end

      def request_results(input)
        Gateway::Api.new(THSRParking::App.config)
          .timetable_info(input)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_results(timetable_json)
        Representer::TimesList.new(OpenStruct.new)
          .from_json(timetable_json)
          .then { |timetable| Success(timetable['data']) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
