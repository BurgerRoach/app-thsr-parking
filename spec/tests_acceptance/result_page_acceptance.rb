# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/result_page'
require_relative 'pages/home_page'

require 'headless'
require 'watir'
require 'chromedriver-helper'
require 'selenium-webdriver'

describe 'Acceptance Tests' do
  include ResultPage::PageFactory

  # DatabaseHelper.setup_database_cleaner

  before do
    # DatabaseHelper.wipe_database
    # @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Visit Result page' do
    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '桃園' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '新竹' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '苗栗' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '台中' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '彰化' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '雲林' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '嘉義' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '台南' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end

    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit(ResultPage, using_params: { city_name: '高雄' }) do |page|
        # THEN: they should see result
        _(page.result_parking_element.present?).must_equal true
      end
    end
  end
end
