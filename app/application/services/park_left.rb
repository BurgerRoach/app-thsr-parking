# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Transaction to store project from Github API to database
    class ParkLeft
      include Dry::Transaction

      step :park_format
      step :find_park

      private

      def park_format(input)
        if input.success?
          park_id = input[:park_id]
          Success(park_id: park_id)
        else
          Failure("Error: #{input.errors.messages.first}")
        end
      end

      def find_park(input)
        park_id = input[:park_id]
        api = THSRParking::THSR::Api.new
        data = api.search_by_park_id(park_id)

        if data.nil?
          input[:data] = nil
        else
          input[:data] = data.parks
          input[:time] = data.update_time
        end
        Success(input)
      rescue StandardError => error
        Failure(error.to_s)
      end
    end
  end
end