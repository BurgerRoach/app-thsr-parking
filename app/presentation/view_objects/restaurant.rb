# frozen_string_literal: true

module Views
  # View for restaurants
  class Restaurant
    def initialize(restaurant)
      @restaurant = restaurant
    end

    def entity
      @restaurant
    end

    def id
      @restaurant.id
    end

    def name
      @restaurant.name
    end

    def latitude
      @restaurant.latitude
    end

    def longtitude
      @restaurant.longtitude
    end

    def open_status
      @restaurant.open_status
    end

    def vicinity
      @restaurant.vicinity
    end

    def rating
      @restaurant.rating
    end

    def ratings_total
      @restaurant.user_ratings_total
    end

    def photo_reference
      @restaurant.photo_reference
    end
  end
end
