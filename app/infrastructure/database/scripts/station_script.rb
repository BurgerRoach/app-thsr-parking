# frozen_string_literal: true

require 'yaml'
require_relative '../orms/station_orm'

module THSRParking
  module DatabaseScript
    # Database init data scripts for Stations
    class Stations
      def initialize(data = nil)
        if data
          @data = data
        else
          file_path = 'app/infrastructure/database/scripts/data/stations.yml'
          @data = YAML.load_file(file_path)
        end
      end

      def init
        @data.each do |item|
          Database::StationOrm.find_or_create(item)
        end
      end
    end
  end
end
