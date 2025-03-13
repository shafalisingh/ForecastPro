require "net/http"

class ForecastsController < ApplicationController

    def get_forecast
        zip_code = params["zip_code"]
        # Validate zip code 
        if !valid_zip_code?(zip_code)
            flash.now[:error] = 'Invalid Zip Code'
            respond_to do |format|
                format.html { render :new } 
            end
        else
            # Cache data to avoid unnecessary API calls
            cache_data = "weather_forecast_#{zip_code}"
            weather_data = Rails.cache.fetch(cache_data, expires_in: 30.minutes) do
                forecast_from_api(zip_code) 
            end
            # Parse desired data from the API response
            @city_name = weather_data["name"]
            @country = weather_data["sys"]["country"]
            @temperature = weather_data["main"]["temp"]
            @feels_like = weather_data["main"]["feels_like"]
            @humidity = weather_data["main"]["humidity"]
            @wind_speed = weather_data["wind"]["speed"]
            @weather_main = weather_data["weather"][0]["main"]
            @weather_description = weather_data["weather"][0]["description"]
            @cloudiness = weather_data["clouds"]["all"]
            respond_to do |format|
                format.html { render :show } 
                format.json { render json: weather_data } 
            end
        end
    end

    # Send an API request to OpenWeatherMap to get forecast
    def forecast_from_api(zip_code)
        url = URI("https://api.openweathermap.org/data/2.5/weather?zip=#{zip_code}&appid=#{ENV['API_KEY']}&units=imperial")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        response = https.request(request)
        JSON.parse(response.read_body)
    end

    # Zip code validation method
    def valid_zip_code?(zip_code)
        zip_code.length == 5
    end
end