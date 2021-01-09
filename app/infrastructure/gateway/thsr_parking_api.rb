# frozen_string_literal: true

require_relative 'list_request'
require 'http'

module THSRParking
  module Gateway
    # Infrastructure to call CodePraise API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      # def cities_list(list)
      #   @request.cities_list(list)
      # end

      # Gets appraisal of a project folder rom API
      # - req: ProjectRequestPath
      #        with #owner_name, #project_name, #folder_name, #project_fullname
      def city_info(req)
        @request.get_city_info(req)
      end

      def park_info(req)
        @request.get_park_info(req)
      end

      def one_park_info(req)
        @request.get_one_park_info(req)
      end

      def timetable_info(req)
        @request.get_timetable_info(req)
      end

      def restaurants_info(req)
        @request.get_restaurants_info(req)
      end

      # HTTP request transmitter
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = config.API_HOST + '/api/v1'
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        # def cities_list(list)
        #   call_api('get', ['cities'],
        #            'list' => Value::WatchedList.to_encoded(list))
        # end

        def get_park_info(req)
          call_api('get', ['cities', req, 'parks'])
        end

        def get_city_info(req)
          call_api('get', ['cities'], {'city_name' => req})
        end

        def get_one_park_info(req)
          call_api('get', ['parks', req[:park_id]])
        end

        def get_timetable_info(req)
          call_api('get', ['cities',req[:station_id],'timetable'], {'date' => req[:date], 'direction' => req[:direction]})
        end

        def get_restaurants_info(req)
          call_api('get', ['restaurants',req[:park_id]], {'radius' => req[:radius]})
        end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
            .then { |str| str ? '?' + str : '' }
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/') + params_str(params)

          HTTP.headers('Accept' => 'application/json').send(method, url)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      class Response < SimpleDelegator
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299).freeze

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def message
          payload['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end