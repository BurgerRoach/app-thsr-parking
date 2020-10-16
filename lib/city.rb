# frozen_string_literal: true

module THSR
  # City
  class City
    def initialize(filtered_data, city)
      @data = filtered_data
      @city = city
    end

    def push_to_arr(element, arr)
      element['CarParkName'] = element['CarParkName']
      arr << element
    end

    def getparkinglot
      check_str_format(@city)
      hash = {}
      arr = []
      parking_availabilities = @data['ParkingAvailabilities']
      hash['UpdateTime'] = @data['UpdateTime']
      screening(parking_availabilities, arr)
      hash['ParkingAvailabilities'] = arr
      hash unless hash['ParkingAvailabilities'].length.zero?
    end

    def screening(hash, arr)
      hash.each do |n|
        push_to_arr(n, arr) if n['CarParkName'].include?(@city)
      end
    end

    def check_str_format(str)
      raise Errors::StrFormatError unless str.is_a? String
    end
  end
end
