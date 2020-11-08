# # frozen_string_literal: true

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
