# frozen_string_literal: true

module THSR
  # Base class for process raw data
  class Base
    def initialize(raw_data, options)
      @data = raw_data
      @options = options
    end

    def flatten
      @data.delete('UpdateInterval')
      @data.delete('SrcUpdateTime')
      @data.delete('SrcUpdateInterval')
      @data.delete('AuthorityCode')
      @data['ParkingAvailabilities'].map do |item|
        item['CarParkName'] = item['CarParkName']['Zh_tw']
        item.delete('Availabilities')
      end

      filter_by_options if @options
      @data
    end

    private

    def filter_by_options
      if @options.key?(:service_status)
        @data['ParkingAvailabilities'].select! { |item| item['ServiceStatus'] == @options[:service_status] }
      end

      if @options.key?(:service_available_level) # There is no service available level, only AvailableSpaces
        @data['ParkingAvailabilities'].select! { |item| item['AvailableSpaces'] >= @options[:available_spaces] }
      end

      if @options.key?(:charge_status)
        @data['ParkingAvailabilities'].select! { |item| item['ChargeStatus'] == @options[:charge_status] }
      end
    end
  end
end
