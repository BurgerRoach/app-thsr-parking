# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/home_page'

require 'headless'
require 'watir'
require 'chromedriver-helper'
require 'selenium-webdriver'

describe 'Acceptance Tests' do
  include PageObject::PageFactory

  # DatabaseHelper.setup_database_cleaner

  before do
    # DatabaseHelper.wipe_database
    # @headless = Headless.new
    @browser = Watir::Browser.new :chrome
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Visit Home page' do
    it '(HAPPY) should connect to the right url' do
      # GIVEN: user enter the url
      # WHEN: go to the url
      visit HomePage do |page|
        # THEN: they should go to the THSRParking url
        _(page.url).include? THSRParking
      end
    end

    it '(HAPPY) should see background image' do
      # GIVEN: user go to homepage
      # WHEN: user in the home page
      visit HomePage do |page|
        # THEN: they should see background image
        _(page.background_image_element.exist?).must_equal true
      end
    end

    it '(HAPPY) should see important buttons' do
      # GIVEN: user go to homepage
      # WHEN: user in the home page
      visit HomePage do |page|
        # THEN: they should see important buttons
        _(page.start_button_element.exist?).must_equal true
        _(page.search_button_element.exist?).must_equal true
      end
    end

    it '(HAPPY) should see active item' do
      # GIVEN: user go to homepage
      # WHEN: user in the home page
      visit HomePage do |page|
        # THEN: they should see active item
        _(page.first_active_item_element.exist?).must_equal true
      end
    end
  end
end
