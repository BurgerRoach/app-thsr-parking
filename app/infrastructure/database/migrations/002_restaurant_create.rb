# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:restaurant) do
      primary_key :id
      foreign_key :station_id, :station

      String      :title, null: false
      String      :description
      String      :latitude, null: false
      String      :longitude, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
