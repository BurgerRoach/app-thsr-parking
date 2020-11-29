# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/home_page'

require 'headless'
require 'watir'

describe 'Acceptance Tests' do
  include PageObject::PageFactory

  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    # @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'Homepage' do
    describe 'Visit homepage' do
      it '(HAPPY) should see basic layout' do
        # GIVEN: user is on the home page
        @browser.goto 'http://localhost:9292/'
        # THEN: they should see right logo
        _(@browser.header(class: 'thsr-header').text).must_equal 'THSR Parking'
      end

      it '(HAPPY) should go to result page' do
        # GIVEN: user is on the home page
        @browser.goto 'http://localhost:9292/'
        # WHEN: they user click search button
        @browser.button(name: 'Search').click
        # THEN: user should go to result page
        @browser.url.include? 'result'
      end
    end
  end
end
