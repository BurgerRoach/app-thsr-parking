# frozen_string_literal: true

module THSR
  module Entity
    # Domain entity for team members
    class Time < Dry::Struct
      include Dry.Types

      attribute :updatetime, Strict::String
    end
  end
end
