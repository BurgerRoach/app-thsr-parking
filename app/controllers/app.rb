# frozen_string_literal: true

require 'roda'
require 'slim'
require_relative '../infrastructure/gateways/api'
require_relative '../models/food'

module THSRParking
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: ['style.scss', 'basic.css'], js: 'index.js', path: 'app/views/assets'
    plugin :halt

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
      time = data['update_time']
      parks = data['parks']
      view 'result', locals: { result: parks, time: time }
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
      time = data['update_time']
      parks = data['parks']
      view 'result', locals: { result: parks, time: time }
      # r.redirect "/result/city?city_name=#{city_name}"
    end

    route do |r|
      r.assets # load CSS and JS

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
