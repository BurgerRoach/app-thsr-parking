# frozen_string_literal: true

module THSRParking
  module Value
    class Thumbsup < SimpleDelegator
      def initialize(restaurant)
        @entity = super(restaurant).to_h
      end

      def adds_up
        @entity[:thumbsup] += 1
        Entity::Restaurant.new(@entity)
      end
    end
  end
end