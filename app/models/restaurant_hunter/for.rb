# frozen_string_literal: true

require_relative '../../models/entities/station'
require_relative '../../models/entities/restaurant'
require_relative '../../models/restaurant_hunter/restaurants'
require_relative '../../models/restaurant_hunter/stations'

module THSRParking
  module RestaurantHunter
    # Finds the right food for an entity object or class
    class For
      ENTITY_HUNTER = {
        Entity::Restaurant => Restaurants,
        Entity::Station => Stations
      }.freeze

      def self.klass(entity_klass)
        ENTITY_HUNTER[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_HUNTER[entity_object.class]
      end
    end
  end
end
