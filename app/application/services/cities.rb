# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Service of city
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
