Rails.application.routes.draw do
  get 'forecast/new', to: 'forecasts#new'
  get 'forecast/show', to: 'forecasts#get_forecast', as: 'weather_forecast'
end
