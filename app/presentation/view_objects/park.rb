# frozen_string_literal: true

module Views
  # View for parking lots
  class Park
    def initialize(park)
      @park = park
    end

    def id
      @park.id
    end

    def name
      @park.name
    end

    def total_spaces
      @park.total_spaces
    end

    def available_spaces
      @park.available_spaces
    end

    def service_status
      @park.service_status
    end

    def full_status
      @park.full_status
    end

    def charge_status
      @park.charge_status
    end
  end
end
