# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module THSRParking
  # Web App
  class App < Roda
    include Errors

    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: ['style.scss', 'basic.css'], js: ['index.js'], path: 'app/presentation/assets'
    plugin :halt
    plugin :flash

    def to_park(route)
      r = route
      r.get 'park' do
        park_id = r.params['park_id']
        pass_park(park_id)
      end
    end

    def pass_park(park_id)
      api = THSRParking::THSR::Api.new
      data = api.search_by_park_id(park_id)
      time = data.update_time
      parks = data.parks

      view_parks = Views::Park.new(parks) # turn into view object

      view 'result', locals: { result: view_parks, time: time }
    end

    def to_city(route)
      r = route
      r.get 'city' do
        city_name = r.params['city_name']
        pass_city(city_name)
      end
    end

    def pass_city(city_name)
      api = THSRParking::THSR::Api.new
      data = api.search_by_city(city_name)
      time = data.update_time
      parks = data.parks

      view_parks = Views::Park.new(parks) # turn into view object

      view 'result', locals: { result: view_parks, time: time }
    end

    # parking details: google map & restaurants
    def to_detail(route)
      # park lat&lng
      park_id = route.params['park_id']
      result = THSRParking::Repository::Locations.find_park_by_id(park_id)
      park_location = {
        'lat': result.latitude,
        'lng': result.longitude
      }

      # puts park_location

      # to detail page
      api_key = ENV['API_KEY']

      radius = '1000'
      type = 'restaurant'

      api = THSRParking::GoogleMap::Api.new(api_key)
      data = api.nearby_search(result.latitude, result.longitude, radius, type)

      puts data

      view_restaurants = Views::Restaurant.new(data) # turn into view object

      view 'detail', locals: { park_location: park_location, restaurants: view_restaurants }
    end

    route do |r|
      r.assets # load CSS and JS

      # GET /
      r.root do
        session[:watching] ||= []
        # station = THSRParking::Repository::For.klass(Entity::Station).all
        # view 'home', locals: { station: station }
        view 'home'
      end

      r.on 'test' do
        view 'test'
      end

      r.on 'result' do
        begin
          # GET /result/park/park_id
          to_park(r)
          # GET /result/city/city_name
          to_city(r)
        rescue IDFormatError
          flash[:error] = 'The ID format should be like "2500" 4 digit numbers'
          r.redirect '/'
        end
      end

      r.on 'detail' do
        to_detail(r)
      end
    end
  end
end
