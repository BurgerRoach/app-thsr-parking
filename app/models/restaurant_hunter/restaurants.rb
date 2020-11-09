# frozen_string_literal: true

require_relative '../../infrastructure/database/orms/restaurant_orm'

module THSRParking
  module RestaurantHunter
    # Repository for Project Entities
    class Restaurants
      def self.all
        Database::RestaurantOrm.all.map { |db_restaurant| rebuild_entity(db_restaurant) }
      end

      def self.find_restaurant_by_id(restaurant_id)
        db_record = Database::RestaurantOrm.first(id: restaurant_id)
        rebuild_entity(db_record)
      end

      def self.find_restaurant_by_name(restaurant)
        db_record = Database::RestaurantOrm.first(restaurant: restaurant)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        Database::RestaurantOrm.self.find_or_create(entity)
        rebuild_entity(db_restaurant)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Restaurant.new(
          # db_record.to_hash.merge(
          # station_id: Station.rebuild_entity(db_record.station)
          # ),
          id: db_record.id,
          station_id: db_record.station_id,
          restaurant: db_record.restaurant,
          type: db_record.type,
          latitude: db_record.latitude,
          longitude: db_record.longitude
        )
      end
    end
  end
end
