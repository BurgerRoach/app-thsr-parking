# frozen_string_literal: true

require_relative 'single_park'

module THSR
  module Entity
    # Domain entity for any coding projects
    class MultiPark < Dry::Struct
      include Dry.Types

      attribute :parks, Strict::Array.of(SinglePark)
    end
  end
end
