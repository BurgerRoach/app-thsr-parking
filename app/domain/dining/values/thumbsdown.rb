# frozen_string_literal: true
require 'delegate'

module THSRParking
  module Value
    class Thumbsdown < SimpleDelegator
      def initialize(restaurant)
        @entity = super(restaurant).to_h
      end

      def adds_down
        @entity[:thumbsdown] += 1
        Entity::Restaurant.new(@entity)
      end
    end
  end
end