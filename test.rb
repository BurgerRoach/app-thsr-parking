# frozen_string_literal: true

require_relative 'lib/api'

api = THSR::Api.new
opts = {
  'service_status': 1,
  'service_available_level': 60,
  'charge_status': 1
}
data = api.search(opts)
print data
