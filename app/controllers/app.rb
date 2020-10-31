# frozen_string_literal: true

require 'roda'
require 'slim'

module THSR
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :halt

    route do |r|
      r.assets # load CSS

      # GET /
      r.root do
        view 'home'
      end

      r.on 'result' do
        # GET /result/park/park_id
        r.on 'park' do
          r.is do # get params
            r.post do
              park_id = r.params['park_id']
              r.redirect "/result/park/#{park_id}"
            end
          end

          r.on String do |park_id|
            # GET /park/park_id
            r.get do
              api = THSRParking::THSR::Api.new
              data = api.search_by_park_id(park_id)
              parks = data['parks']

              view 'result', locals: { result: parks }
            end
          end
        end

        # GET /result/city/city_name
        r.on 'city' do
          r.is do # get params
            r.post do
              city_name = r.params['city_name']
              puts city_name

              api = THSRParking::THSR::Api.new
              data = api.search_by_city(city_name)
              parks = data['parks']

              puts parks

              view 'result', locals: { result: parks }

              # r.redirect "/result/city/#{city_name}"
            end
          end

          # r.on String do |city_name|
          #   puts city_name
          #   # GET /result/city_name
          #   r.get do
          #     api = THSRParking::THSR::Api.new
          #     data = api.search_by_city(city_name)
          #     parks = data['parks']

          #     puts parks

          #     view 'result', locals: { result: parks }
          #   end
          # end
        end
      end
    end
  end
end
