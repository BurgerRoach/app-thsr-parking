# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module THSRParking
  # Web App
  class App < Roda
    include Errors

    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :assets, css: ['style.scss', 'basic.css'], js: ['index.js', 'portal.js'], path: 'app/presentation/assets'
    plugin :halt
    plugin :flash

    def to_park(route)
      r = route
      r.get 'park' do
        parkid_format = THSRParking::Forms::IDFormat.new.call(r.params)
        park_made = Service::ParkLeft.new.call(parkid_format)

        if park_made.failure?
          flash[:error] = park_made.failure
          r.redirect '/'
        end
        # park_id = r.params['park_id']
        # pass_park(park_id)
        results = park_made.value!
        flash.now[:notice] = 'No match result' if (results[:data].length == 0)
        view_parks = Views::Park.new(results[:data]) # turn into view object
        view 'result', locals: { result: view_parks, time: results[:time] }
      end
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
      db_data = THSRParking::Repository::OtherParks.find_park_by_city(city_name)
      data = api.search_by_city(city_name)
      time = data.update_time
      parks = data.parks.push(*db_data.parks)

      flash.now[:notice] = 'No match result' if parks.length.zero?

      view_parks = Views::Park.new(parks) # turn into view object

      view 'result', locals: { result: view_parks, time: time }
    end

    # parking details: google map & restaurants
    def to_detail(route)
      # park lat&lng
      park_id = route.params['park_id']
      restaurant_made = Service::RestaurantAround.new.call({park_id:park_id})
      if restaurant_made.failure?
        flash[:error] = restaurant_made.failure
        r.redirect '/'
      end
      results = restaurant_made.value!
      flash.now[:notice] = 'No match result' if (results[:data].length == 0)
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
        session[:watching] ||= []
        # station = THSRParking::Repository::For.klass(Entity::Station).all
        # view 'home', locals: { station: station }
        view 'home'
      end

      r.on 'test' do
        view 'test'
      end

      r.on 'result' do
        to_park(r)
        to_city(r)
      end

      r.on 'detail' do
        to_detail(r)
      end
    end
  end
end
