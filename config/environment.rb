# frozen_string_literal: true

require 'roda'
require 'econfig'
require 'delegate'

module THSRParking
  # Configuration for the App
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    use Rack::Session::Cookie, secret: config.SESSION_SECRET # Session
    secret_config = YAML.safe_load(File.read('./config/secrets.yml'))
    ENV['API_KEY'] = secret_config['API_KEY']
  end
end
