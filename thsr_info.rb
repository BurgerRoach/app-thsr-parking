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
      park_origin_id: item['CarParkID'],
      name: item['CarParkName']['Zh_tw'],
      city: item['City'],
      latitude: item['CarParkPosition']['PositionLat'].to_s,
      longitude: item['CarParkPosition']['PositionLon'].to_s
    }
  end
end
api_url = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/CarPark/Rail/THSR?$orderby=CarParkID&$format=JSON'
data = call_thsr_api(api_url)['CarParks']
File.write('parks.yml', filter_data(data).to_yaml)
