# frozen_string_literal: true

require 'vcr'
require 'webmock'

# Setting up VCR
class VcrHelper
  CASSETTES_FOLDER = 'spec/fixtures/cassettes/'.freeze
  THSR_CASSETTE = 'thsr_api'.freeze

  def self.setup_vcr
    VCR.configure do |c|
      c.cassette_library_dir = CASSETTES_FOLDER
      c.hook_into :webmock
      c.ignore_localhost = true
    end
  end

  def self.configure_vcr_for_thsr
    VCR.insert_cassette THSR_CASSETTE, record: :new_episodes, match_requests_on: %i[method uri headers]
  end

  def self.eject_vcr
    VCR.eject_cassette
  end
end
