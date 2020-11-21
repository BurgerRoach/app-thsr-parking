# frozen_string_literal: true

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

#     describe 'Add Project' do
#       it '(HAPPY) should be able to request a project' do
#         # GIVEN: user is on the home page without any projects
#         @browser.goto homepage

#         # WHEN: they add a project URL and submit
#         good_url = "https://github.com/#{USERNAME}/#{PROJECT_NAME}"
#         @browser.text_field(id: 'url_input').set(good_url)
#         @browser.button(id: 'project_form_submit').click

#         # THEN: they should find themselves on the project's page
#         @browser.url.include? USERNAME
#         @browser.url.include? PROJECT_NAME
#       end

#       it '(BAD) should not be able to add an invalid project URL' do
#         # GIVEN: user is on the home page without any projects
#         @browser.goto homepage

#         # WHEN: they request a project with an invalid URL
#         bad_url = 'foobar'
#         @browser.text_field(id: 'url_input').set(bad_url)
#         @browser.button(id: 'project_form_submit').click

#         # THEN: they should see a warning message
#         _(@browser.div(id: 'flash_bar_danger').present?).must_equal true
#         _(@browser.div(id: 'flash_bar_danger').text.downcase).must_include 'invalid'
#       end

#       it '(SAD) should not be able to add valid but non-existent project URL' do
#         # GIVEN: user is on the home page without any projects
#         @browser.goto homepage

#         # WHEN: they add a project URL that is valid but non-existent
#         sad_url = "https://github.com/#{USERNAME}/foobar"
#         @browser.text_field(id: 'url_input').set(sad_url)
#         @browser.button(id: 'project_form_submit').click

#         # THEN: they should see a warning message
#         _(@browser.div(id: 'flash_bar_danger').present?).must_equal true
#         _(@browser.div(id: 'flash_bar_danger').text.downcase).must_include 'could not find'
#       end
#     end
  end
end
