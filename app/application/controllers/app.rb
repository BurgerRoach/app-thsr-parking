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
      parks_made = Service::Parks.new.find_park_by_city(city_name)

      if parks_made.failure?
        flash[:error] = parks_made.failure
        route.redirect '/'
      end

      parks, update_time = parks_made.value!

      flash.now[:notice] = 'No match result' if parks.length.zero?

      view_parks = Views::Park.new(parks) # turn into view object

      view 'result', locals: { result: view_parks, time: update_time }
    end

    # parking details: google map & restaurants
    def to_detail(route)
      # park lat&lng
      park_id = route.params['park_id']
      restaurant_made = Service::RestaurantAround.new.call({ park_id: park_id })
      if restaurant_made.failure?
        flash[:error] = restaurant_made.failure
        route.redirect '/'
      end
      results = restaurant_made.value!
      flash.now[:notice] = 'No match result' if results[:data].length.zero?
      park_location = {
        'lat': results[:lat],
        'lng': results[:lng]
      }

      view_restaurants = Views::Restaurant.new(results[:data]) # turn into view object

      view 'detail', locals: { park_location: park_location, restaurants: view_restaurants }
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
