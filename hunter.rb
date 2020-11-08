# frozen_string_literal: true

require_relative 'app/init'

### test  RestaurantHunter Stations ###
# test find station by id
result = THSRParking::RestaurantHunter::Stations.find_station_by_id('1')
puts result.to_h

# test find station by name
result = THSRParking::RestaurantHunter::Stations.find_station_by_name('高鐵台中站')
puts result.to_h

# test find_station_retaurant
# result = THSRParking::RestaurantHunter::Stations.find_station_retaurant('1')



### test  RestaurantHunter Restaurants ###
# test find restaurant by id
result = THSRParking::RestaurantHunter::Restaurants.find_restaurant_by_id('3')
puts result.to_h

# test find restaurant by name
result = THSRParking::RestaurantHunter::Restaurants.find_restaurant_by_name('井町日式蔬食-高鐵店')
puts result.to_h
