# frozen_string_literal: true

require_relative 'app/models/gateways/api'

api = THSRParking::THSR::Api.new

# opts = {
#   'service_status': 1,
#   'service_available_level': 60,
#   'charge_status': 1
# }
# data = api.search(opts)
# print data


## City ##
data = api.search_by_city('新竹')
print data

## Park ID ##
# data = api.search_by_park_id('2600')
# print data['parks']
