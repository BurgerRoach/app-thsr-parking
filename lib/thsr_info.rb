# frozen_string_literal: true

require 'net/http'
require 'yaml'
require 'JSON'

def call_thsr_api(url)
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  JSON.parse(response.body)
end

def filter_data(input)
  input.map do |item|
    {
      'CarParkID' => item['CarParkID'],
      'CarParkName' => item['CarParkName']['Zh_tw']
    }
  end
end
api_url = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/ParkingAvailability/Rail/THSR?$format=JSON'
data = call_thsr_api(api_url)['ParkingAvailabilities']
File.write('spec/fixtures/thsr_results.yml', filter_data(data).to_yaml)
