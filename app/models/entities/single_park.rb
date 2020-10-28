# frozen_string_literal: true

module THSR
  module Entity
    # Domain entity for any coding projects
    class SinglePark < Dry::Struct
      include Dry.Types

      attribute :id,               Strict::Integer
      attribute :name,             Strict::String
      attribute :service,          Strict::Integer
      attribute :fullstatus,       Strict::String
      attribute :charge,           Strict::Integer
      attribute :totalspace,       Strict::Integer
      attribute :available,        Strict::Integer
    end
  end
end
