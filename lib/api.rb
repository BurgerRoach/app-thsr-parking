# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'base'
require_relative 'errors'
# require_relative 'city'
# require_relative 'park'

module THSR
  # Library for THSR API
  class Api
    include Errors
    HTTP_ERROR = {
      400 => Errors::BadRequest,
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze

    API_URL = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/ParkingAvailability/Rail/THSR?$format=JSON'

    def search(options = {})
      # @params options {hash}
      #   - service_status {int/nil} 停車場營業狀態:[0:'休息中',1:'營業中',2:'暫停營業']
      #   - service_available_level {int/nil} 尚有空位門檻
      #   - charge_status {int/nil} 停車收費狀態:[0:'不收費',1:'正常收費',2:'暫停收費']
      # @return {array-hash} the response data after filtered
      # {
      #   "UpdateTime": "2020-10-13T14:35:57+08:00",
      #   "ParkingAvailabilities": [{
      #     "CarParkID": "2100",
      #     "CarParkName": "高鐵桃園站戶外短期停車場(P1)",
      #     "TotalSpaces": 46,
      #     "AvailableSpaces": 30,
      #     "ServiceStatus": 1,
      #     "FullStatus": 0,
      #     "ChargeStatus": 1,
      #     "DataCollectTime": "2020-10-13T14:35:12+08:00"
      #   }]
      # }
      raise Errors::OptionsError if check_opts?(options) == false

      raw_data = call_api
      THSR::Base.new(raw_data, options).flatten
    end

    def search_by_city(city, options = {})
      # @params city {string} city name
      # @params options {hash}
      # @return {array-hash} the response data after filtered by city name
      filtered_data = search(options)
      THSR::City.new(filtered_data, city)
    end

    def search_by_park_id(park_id, options = {})
      # @params park_id {int} city name
      # @params options {hash}
      # @return {hash} the response data after filtered by park id
      filtered_data = search(options)
      THSR::Park.new(filtered_data, park_id).choose
    end

    private

    def call_api
      uri = URI(API_URL)
      response = Net::HTTP.get_response(uri)
      check_req_status?(response.code) ? JSON.parse(response.body) : raise(HTTP_ERROR[response.code])
    end

    def check_req_status?(status_code)
      HTTP_ERROR.keys.include?(status_code) ? false : true
    end

    def check_opts?(opts)
      option_keys = %i[service_status service_available_level charge_status]

      return true if opts.empty?

      opts.each_key { |k| return false if option_keys.include?(k) == false }
      true
    end
  end
end
