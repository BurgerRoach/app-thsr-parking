# frozen_string_literal: true

require_relative '../utils/errors'

module THSRParking
  # Provides access to THSR park spacing data
  module THSR
    # Data Mapper: THSR park spacing data -> SinglePark Entity
    class City
      def initialize(data_instance, city)
        @data_instance = data_instance # MultiPark instance
        @city = city
      end

      def get
        raise Errors::StrFormatError if invalid_city_format?

        select_by_city

        @data_instance
      end

      private

      def select_by_city
        @data_instance.parks.select! { |item| item.name.include?(@city) }
      end

      def invalid_city_format?
        return true unless @city.is_a? String

        false
      end
    end
  end
end
