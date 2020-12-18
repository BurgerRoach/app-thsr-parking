# frozen_string_literal: true

# Page object for home page
class ResultPage
  include PageObject

  page_url THSRParking::App.config.APP_HOST + '/result/city?city_name=<%= params[:city_name]%>'
  # page_url "#{THSRParking::App.config.APP_HOST}/result/city?city_name<%= params[:city_name]%>"

  section(:result_parking, id: 'result_section')

  def check_result
    self.result_parking
  end
end
