# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class City < Dry::Struct
      include Dry.Types

      # attribute :update_time,       Strict::String.optional
      attribute :city_id,           Strict::String
      attribute :name,              Strict::String
      attribute :img_src,           Strict::String
      attribute :credit,            Strict::String
    end
  end
end
