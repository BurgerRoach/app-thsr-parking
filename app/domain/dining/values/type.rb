# frozen_string_literal: true

module THSRParking
  module Value
    class Type < SimpleDelegator
      def initialize(restaurant)
        @entity = super(restaurant).to_h
      end  
      def change_type(description)
        @entity[:type] = description
        Entity::Restaurant.new(@entity)
      end
    end
  end
end