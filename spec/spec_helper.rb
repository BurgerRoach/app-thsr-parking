# frozen_string_literal: true

require 'yaml'
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/api'
require_relative '../lib/errors'

require_relative '../app/models/gateways/api'

# CORRECT = YAML.safe_load(File.read('spec/fixtures/thsr_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'thsr_api'
