# frozen_string_literal: true

require 'sequel'

# db_url = "sqlite://app/infrastructure/database/local/dev.db"
# Sequel.connect(db_url)

module THSRParking
  module Database
    # Object Relational Mapper for Restaurant
    class RestaurantOrm < Sequel::Model(:restaurants)
      many_to_one :owner,
                  class: :'THSRParking::Database::StationOrm'

      plugin :timestamps, update_on_create: true

      def self.find_or_create(restaurant_info)
        first(restaurant: restaurant_info[:restaurant]) || create(restaurant_info)
      end
    end
  end
end
