# frozen_string_literal: true

module THSRParking
  module THSR
    # Repository for Members
    class Stations
      def self.find_station_name(station_name)
        rebuild_entity Database::StationOrm.first(stationName: station_name)
      end

      def self.find_latitude(latitude)
        rebuild_entity Database::StationOrm.first(latitude: latitude)
      end

      def self.find_longitude(longitude)
        rebuild_entity Database::StationOrm.first(longitude: longitude)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Station.new(
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

      def self.db_find_or_create(entity)
        Database::StationOrm.find_or_create(entity.to_attr_hash)
      end

      # private :self.rebuild_entity, rebuild_many, db_find_or_create
    end
  end
end
