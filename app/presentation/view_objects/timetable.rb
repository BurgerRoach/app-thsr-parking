# frozen_string_literal: true

module Views
  # View for timetable
  class Timetable
    def initialize(time)
      @time = time
    end

    def each
      @time.each do |item|
        yield item
      end
    end

    def entity
      @time
    end

    def city_id
      @time.city_id
    end

    def name
      @time.name
    end

    def train_no
      @time.train_no
    end

    def direction
      @time.direction
    end

    def start_station_name
      @time.start_station_name
    end

    def end_station_name
      @time.end_station_name
    end

    def arrival_time
      @time.arrival_time
    end

    def departure_time
      @time.departure_time
    end
  end
end
