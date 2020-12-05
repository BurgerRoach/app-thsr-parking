# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Retrieves array of all listed shop entities
    class Cities
      include Dry::Transaction

      def list
        cities = Repository::Cities.all

        Success(cities)
      rescue StandardError => e
        Failure(e.to_s)
      end
    end
  end
end
