# # frozen_string_literal: true

module THSRParking
  module THSR
    # Finds the right food for an entity object or class
    class For
      ENTITY_FOOD = {
        Entity::Restaurant => Restaurant,
        Entity::Station => Station
      }.freeze

      def self.klass(entity_klass)
        ENTITY_FOOD[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_FOOD[entity_object.class]
      end
    end
  end
end
