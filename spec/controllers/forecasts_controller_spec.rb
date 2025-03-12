require "rails_helper"
require "net/http"
require 'dotenv'

RSpec.describe ForecastsController, type: :controller do
  describe 'Check invalid zip code' do
    let(:zip_code) { '123' }

    it 'returns an error message when zip code is invalid' do
      post :get_forecast, params: { zip_code: zip_code }
      expect(response.body).to include("Invalid Zip Code")
    end
  end

  describe 'GET /weather' do
    let(:zip_code) { '98001' }
    let(:api_key) { ENV['API_KEY'] }
    it 'returns a successful response from the API' do
      get "get_forecast", params: { zip_code: zip_code }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('show')
    end
  end
end

RSpec.feature "WeatherPage", type: :feature do
  scenario 'Check that the show view has the right content' do
    visit "/forecast/show?zip_code=98001" 
    expect(page).to have_current_path("/forecast/show?zip_code=98001")
    expect(page).to have_content('Auburn') 
    expect(page).to have_content(/Temperature: \d+(\.\d+)?°F/) 
    expect(page).to have_content(/Humidity: \d+%/)
    expect(page).to have_content(/Wind Speed: \d+(\.\d+)? m\/s/) 
    expect(page).to have_content(/Weather: .+/) 
    expect(page).to have_content(/Cloudiness: \d+%/)  
  end
end