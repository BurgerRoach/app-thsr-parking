# frozen_string_literal: true

# require_relative '../../infrastructure/database/orms/station_orm'

module THSRParking
  module RestaurantHunter
    # Repository for Members
    class Stations
      # def self.find_station_retaurant(station_id)
      #   db_station = Database::StationOrm
      #     .join(:restaurants, station_id: station_id)
      #     .where(station_id: station_id)

      #   db_station.to_a.each { |item| puts item.station }
      #   # puts db_station.to_a
      #   # rebuild_entity(db_station)
      # end

      def self.all
        Database::StationOrm.all.map { |db_record| rebuild_entity(db_record) }
      end

      def self.find_station_by_id(station_id)
        rebuild_entity Database::StationOrm.first(id: station_id)
      end

      def self.find_station_by_name(station_name)
        rebuild_entity Database::StationOrm.first(station: station_name)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Station.new(
          id: db_record.id,
          station: db_record.station,
          latitude: db_record.latitude,
          longitude: db_record.longitude
        )
      end

      def self.rebuild_many(db_records)
        db_records.map do |db_station|
          Stations.rebuild_entity(db_station)
        end
      end

      # def self.rebuild_station_restaurant_entity(db_record)
      #   return nil unless db_record

      #   Entity::Project.new(
      #     db_record.to_hash.merge(
      #       owner: Members.rebuild_entity(db_record.owner),
      #       contributors: Members.rebuild_many(db_record.contributors)
      #     )
      #   )
      # end

      def self.db_find_or_create(entity)
        Database::StationOrm.find_or_create(entity.to_attr_hash)
      end

      # private :self.rebuild_entity, rebuild_many, db_find_or_create
    end
  end
end
