# frozen_string_literal: true

module THSR
  # Model for park
  class Park
    def initialize(park_id, filtered_data)
      @data = filtered_data
      @park_id = park_id
    end

    def onehash
      [@data.first].to_h.merge(@data['ParkingAvailabilities'].inject(:merge)) # Transform into one hash
    end

    def get
      raise Errors::IDFormatError if invalid_id_format?

      @data['ParkingAvailabilities'].select! { |item| item['CarParkID'] == @park_id }
      return onehash unless @data['ParkingAvailabilities'][0].nil?

      nil # 'Sorry, no parking lot can meet your needs'
    end

    private

    def invalid_id_format?
      id_format = /^\d{4}$/
      return true if id_format.match(@park_id).nil?

      false
    end
  end
end
