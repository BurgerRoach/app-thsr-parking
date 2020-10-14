# frozen_string_literal: true

module THSR
  # Model for park
  class Park
    def initialize(filtered_data, park_id)
      @data = filtered_data
      @park_id = park_id
    end

    def onehash
      [@data.first].to_h.merge(@data['ParkingAvailabilities'].inject(:merge)) # Transform into one hash
      # @data['ParkingAvailabilities'] = @data['ParkingAvailabilities'][0] # remain Parking Availabilities
      # @data
    end

    def choose
      @data['ParkingAvailabilities'].select! do |item|
        item['CarParkID'] == @park_id
      end
      return onehash unless @data['ParkingAvailabilities'][0].nil?

      'Sorry, no parking lot can meet your needs'
    end
  end
end
