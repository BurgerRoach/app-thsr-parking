# frozen_string_literal: true

require_relative 'app/init'

# api = THSR::Api.new
# opts = {
#   'service_status': 1,
#   'service_available_level': 10,
#   'charge_status': 1
# }
# id = '2500'
# data = api.search(opts)
# print data
# park = api.search_by_park_id(id, opts)
# puts "\n\n#{park}"

# city = ''
# data = api.search(opts)
# puts data
# pkl_city = api.search_by_city(city, opts)
# puts "\n#{pkl_city}"

city = '台中'
api = THSRParking::THSR::Api.new
data = api.search_by_city(city)
parks = data['parks']
puts data
puts parks[0]['name']
