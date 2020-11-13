# frozen_string_literal: true

module THSRParking
  module Value
    class Remain < SimpleDelegator
      def initialize(city)
        @entity = super(city).parks
      end

      def nothing_left?
        @entity.each do |obj|
            return FALSE if obj.available_spaces > 0
        end
        return TRUE
      end
    end
  end
end