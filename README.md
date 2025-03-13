Forecast Pro is a Ruby on Rails application that provides weather forecasts based on a given zip code using the OpenWeatherMap API. The app caches weather data to improve performance and reduce API calls.

Description:

- Fetches current weather data using OpenWeatherMap API.
- Validates zip codes before making API calls.
- Caches weather data for 30 minutes to optimize API usage.

System Dependencies:
Ruby '3.4.2'
Rails '~> 8.0.1'

Installation:

- git clone https://github.com/shafalisingh/ForecastPro.git
- cd ForecastPro
- bundle install
Set up environment variables:
- Create a .env file in the root directory and add your AP
- API_KEY=6163c52a7b8a165ab3dfc86134538dea
Note: It is not a good practice to share API keys publicly. However, since the key is required for the API, declaring it here in the README for setup purposes.
- Start your server : rails server
- Go to: http://localhost:3000/forecast/new
- Enter the valid zip code

RSpec Tests:
- To run the tests: bundle exec rspec

