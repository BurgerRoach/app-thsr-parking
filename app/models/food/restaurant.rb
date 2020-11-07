# frozen_string_literal: true

module THSRParking
  module THSR
    # Repository for Project Entities
    class Restaurant
      def self.all
        Database::RestaurantOrm.all.map { |db_restaurant| rebuild_entity(db_restaurant) }
      end

    #   def self.find_full_name(owner_name, project_name)
    #     # SELECT * FROM `projects` LEFT JOIN `members`
    #     # ON (`members`.`id` = `projects`.`owner_id`)
    #     # WHERE ((`username` = 'owner_name') AND (`name` = 'project_name'))
    #     db_restaurant = Database::RestaurantOrm
    #       .left_join(:members, id: :owner_id)
    #       .where(username: owner_name, name: project_name)
    #       .first
    #     rebuild_entity(db_restaurant)
    #   end

      def self.find(entity)
        find_restaurant(entity.restaurant)
      end

      def self.find_station_id(station_id)
        db_record = Database::RestaurantOrm.first(station_id: station_id)
        rebuild_entity(db_record)
      end

      def self.find_restaurant(restaurant)
        db_record = Database::RestaurantOrm.first(restaurant: restaurant)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        raise 'Restaurant already exists' if find(entity)

        db_restaurant = PersistProject.new(entity).call
        rebuild_entity(db_restaurant)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Restaurant.new(
          # db_record.to_hash.merge(
          # station_id: Station.rebuild_entity(db_record.station)
          # ),
          station_id: db_record.station_id,
          restaurant: db_record.restaurant,
          type: db_record.type,
          latitude: db_record.latitude,
          longitude: db_record.longitude
        )
      end

      # Helper class to persist project and its members to database
      class PersistProject
        def initialize(entity)
          @entity = entity
        end

        def create_restaurant
          Database::RestaurantOrm.create(@entity.to_attr_hash)
        end

        def call
          station_id = Station.db_find_or_create(@entity.station_id)

          create_restaurant.tap do |db_restaurant|
            db_restaurant.update(station_id: station_id)

            @entity.contributors.each do |contributor|
              db_project.add_contributor(Members.db_find_or_create(contributor))
            end
          end
        end
      end
    end
  end
end
