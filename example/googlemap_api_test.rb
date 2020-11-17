# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

api_key = 'AIzaSyCKFRjdZEMng_7iZGdqpVZTBnmQ2pkbans'

lat = '24.985175'
lng = '121.440307'
radius = '500'
type = 'restaurant'

api = THSRParking::GoogleMap::Api.new(api_key)
data = api.nearby_search(lat, lng, radius, type)

puts data
