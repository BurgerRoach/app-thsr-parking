# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for City Entities
    class Cities
      def self.all
        Database::CityOrm.all.map { |db_city| rebuild_entity(db_city) }
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::City.new(
          city_id: db_record.city_id,
          name: db_record.name,
          latitude: db_record.latitude,
          longitude: db_record.longitude
        )
      end
    end
  end
end
