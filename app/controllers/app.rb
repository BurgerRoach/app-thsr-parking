# frozen_string_literal: true

require 'roda'
require 'slim'

module THSR
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :halt

    route do |routing|
      routing.assets # load CSS

      # GET /
      routing.root do
        view 'home'
      end

      routing.on 'result' do
        routing.is do
          # GET /result/
          routing.post do
            park_info = routing.params['park_id']
            park_id = park_info

            routing.redirect "result/#{park_id}"
          end
        end

        routing.on String do |park_id|
          # GET /result/park_id
          routing.get do
            api = THSRParking::THSR::Api.new
            data = api.search_by_park_id(park_id)
            parks = data['parks']

            view 'result', locals: { result: parks }
          end
        end
      end

      routing.on 'result' do
        routing.is do
          # GET /result/
          routing.post do
            park_info = routing.params['city_name']
            city_name = park_info

            routing.redirect "result_city/#{city_name}"
          end
        end
        routing.on String do |city_name|
          # GET /result/city_name
          routing.get do
            api = THSRParking::THSR::Api.new
            data = api.search_by_city(city_name)
            parks = data['parks']

            view 'result_city', locals: { result: parks }
          end
        end
      end
    end
  end
end
