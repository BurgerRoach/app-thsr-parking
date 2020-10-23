# frozen_string_literal: true

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/api'
require_relative '../lib/errors'

CORRECT = YAML.safe_load(File.read('fixtures/thsr_results.yml'))

CASSETTES_FOLDER = 'fixtures/cassettes'
CASSETTE_FILE = 'thsr_api'
