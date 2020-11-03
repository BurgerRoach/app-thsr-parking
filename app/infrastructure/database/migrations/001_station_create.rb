# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:station) do
      primary_key :id

      String      :station, unique: true, null: false
      String      :latitude, null: false
      String      :longitude, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
