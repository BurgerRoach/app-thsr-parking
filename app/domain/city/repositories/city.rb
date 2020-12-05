# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for Project Entities
    class City
      def self.all
        Database::ParkOrm.all.map { |db_park| rebuild_entity(db_park) }
      end

      def self.find_city_by_id(city_id)
        db_record = Database::ParkOrm.first(city_id: city_id)
        rebuild_entity(db_record)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::City.new(
          city_id: db_record.city_id,
          name: db_record.name,
          img_src: db_record.img_src,
          credit: db_record.credit
        )
      end
    end
  end
end
