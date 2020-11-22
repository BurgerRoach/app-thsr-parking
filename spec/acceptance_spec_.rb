# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

require_relative 'spec_helper'
require_relative 'helpers/database_helper'
require_relative 'helpers/vcr_helper'

require 'headless'
require 'watir'

describe 'Acceptance Tests' do
  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'Homepage' do
    describe 'Visti homepage' do
      it '(HAPPY) should see basic layout' do
        @browser.goto 'https://thsr-parking.herokuapp.com/'

        _(@browser.span.text).must_equal 'THSR Parking'
      end
    end
  end
end
