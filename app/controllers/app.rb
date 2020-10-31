# frozen_string_literal: true

require 'roda'
require 'slim'

module THSR
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :halt

    def to_park(route)
      r = route
      r.on 'park' do
        r.is do # get params
          r.post do
            park_id = r.params['park_id']
            r.redirect "/result/park/#{park_id}"
          end
        end
        pass_park(route)
      end
    end

    def pass_park(route)
      r = route
      r.on String do |park_id|
        # GET /park/park_id
        r.get do
          api = THSRParking::THSR::Api.new
          data = api.search_by_park_id(park_id)
          time = data['update_time']
          parks = data['parks']
          view 'result', locals: { result: parks, time: time }
        end
      end
    end

    def to_city(route)
      r = route
      r.on 'city' do
        r.is do # get params
          r.post do
            city_name = r.params['city_name']

            pass_city(city_name)
          end
        end
      end
    end

    def pass_city(city_name)
      api = THSRParking::THSR::Api.new
      data = api.search_by_city(city_name)
      time = data['update_time']
      parks = data['parks']
      view 'result', locals: { result: parks, time: time }
      # r.redirect "/result/city?city_name=#{city_name}"
    end

    route do |r|
      r.assets # load CSS

      # GET /
      r.root do
        view 'home'
      end

      r.on 'result' do
        # GET /result/park/park_id
        to_park(r)

        # GET /result/city/city_name
        to_city(r)
      end
    end
  end
end
