# frozen_string_literal: false

require 'minitest/autorun'
# require 'minitest/rg'
require_relative '../lib/api'
require_relative '../lib/errors'

describe 'Tests THSR API library' do
  describe 'Search real time inquiry information' do
    it 'HAPPY: should provide correct search information' do
      data = THSR::Api.new.search

      _(data['ParkingAvailabilities'].size).wont_equal 0
    end

    it 'HAPPY: should provide correct search information' do
      opts = { 'charge_status': 2 }
      data = THSR::Api.new.search(opts)

      _(data['ParkingAvailabilities'].size).must_equal 0
    end

    it 'SAD: should raise exception on incorrect options' do
      _(proc do
        THSR::Api.new.search({ 'hello': 2 })
      end).must_raise Errors::OptionsError
    end
  end
end
