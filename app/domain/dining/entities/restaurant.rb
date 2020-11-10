# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class Restaurant < Dry::Struct
      include Dry.Types

      # attribute :update_time,     Strict::String.optional
      attribute :id,                Strict::Integer
      attribute :station_id,        Strict::Integer
      attribute :restaurant,        Strict::String
      attribute :type,              Strict::String
      attribute :latitude,          Strict::String
      attribute :longitude,         Strict::String
      # attribute :created_at,        Strict::String
      # attribute :updated_at,        Strict::String
    end
  end
end
