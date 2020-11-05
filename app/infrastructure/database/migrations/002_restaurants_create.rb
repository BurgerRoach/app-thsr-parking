# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:restaurants) do
      primary_key :id
      foreign_key :station_id

      String      :restaurant, null: false
      String      :type
      String      :latitude, null: false
      String      :longitude, null: false

      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
