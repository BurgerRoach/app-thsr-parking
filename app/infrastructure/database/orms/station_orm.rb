# frozen_string_literal: true

require 'sequel'

# db_url = "sqlite://app/infrastructure/database/local/dev.db"
# Sequel.connect(db_url)

module THSRParking
  module Database
    # Object-Relational Mapper for Station
    class StationOrm < Sequel::Model(:stations)
      one_to_many :owned_restaurants,
                  class: :'THSRParking::Database::RestaurantOrm',
                  key: :id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(station_info)
        first(station: station_info[:station]) || create(station_info)
      end
    end
  end
end
