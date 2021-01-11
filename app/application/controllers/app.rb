# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'
require 'json'

module THSRParking
  # Web App
  class App < Roda
    include Errors

    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: ['style.scss', 'basic.css'], js: ['index.js', 'portal.js'], path: 'app/presentation/assets'
    plugin :halt
    plugin :flash

    def to_city(route)
      r = route
      r.get 'city' do
        city_name = r.params['city_name']
        pass_city(route, city_name)
      end
    end

    def pass_city(route, city_name)
      parks_made = Service::Parks.new.call(city_name)

      # timetable_made = Service::Timetable.new.call({
      #   'city_name': city_name,
      #   'date': Date.today,
      #   'direction': '0'
      # })

      if parks_made.failure?
        flash[:error] = parks_made.failure
        route.redirect '/'
      end

      # if timetable_made.failure?
      #   flash[:error] = timetable_made.failure
      #   route.redirect '/'
      # end

      parks = parks_made.value!
      # timetables = timetable_made.value!

      # puts timetables

      flash.now[:notice] = 'No match result' if parks.length.zero?

      view_parks = Views::Park.new(parks) # turn into view object

      view 'result', locals: { result: view_parks, time: "update_time" }
    end

    # parking details: google map & restaurants
    def to_detail(route)
      # get park info
      park_id = route.params['park_id']
      park_info = Service::Park.new.call({ park_id: park_id })
      park_info_result = park_info.value!

      # get timetable
      direction = route.params['direction']
      direction = '0' if direction.nil?

      direction_text = 'Southward'
      direction_text = 'Northward' if direction == '1'

      timetable_made = Service::Timetable.new.call({
        'city_name': park_info_result['result']['city'],
        'date': Date.today,
        'direction': direction
      })

      if timetable_made.failure?
        flash[:error] = timetable_made.failure
        route.redirect '/'
      end

      timetables = timetable_made.value!

      # get restaurants
      park_id = route.params['park_id']
      restaurant_made = Service::RestaurantAround.new.call({ park_id: park_id, radius: '500'})
      if restaurant_made.failure?
        flash[:error] = restaurant_made.failure
        route.redirect '/'
      end
      results = restaurant_made.value!
      flash.now[:notice] = 'No match result' if results[:restaurants].length.zero?
      first_location = {
        'lat': park_info_result['result'].latitude,
        'lng': park_info_result['result'].longitude
      }

      # views
      view_timetable = Views::Timetable.new(timetables) # turn into view object
      view_restaurants = Views::Restaurant.new(results[:restaurants]) # turn into view object
      restaurant_length = results[:restaurants].length

      view 'detail', locals: {
        direction: direction_text,
        first_location: first_location,
        restaurants: view_restaurants,
        restaurant_length: restaurant_length,
        timetable: view_timetable
      }
    end

    route do |r|
      r.assets # load CSS and JS

      # GET /
      r.root do
        view 'home'
      end

      r.on 'test' do
        view 'test'
      end

      r.on 'get_city' do
        city = r.params['city_name']
        station = Service::Cities.new.find(city).value!
        return station.to_h.to_json
      end

      r.on 'result' do
        to_city(r)
      end

      r.on 'detail' do
        to_detail(r)
      end
    end
  end
end
