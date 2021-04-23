class Api::V1::ForecastsController < ApplicationController

  def show
    location_conn = Faraday.new("http://www.mapquestapi.com/geocoding/v1/address")
    location = location_conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = params[:location]
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
    parsed = JSON.parse(location.body, symbolize_names: true)
    lat_lng = parsed[:results].first[:locations].first[:latLng]

    forecast_conn = Faraday.new("https://api.openweathermap.org")
    forecast = forecast_conn.get("/data/2.5/onecall") do |f|
    f.params[:appid] = ENV['OPENWEATHER_API_KEY']
    f.params[:lat] = lat_lng[:lat]
    f.params[:lng] = lat_lng[:lng]
    end
    require 'pry'; binding.pry

    parsed_forcast = JSON.parse(forecast.body, symbolize_names: true)

    render json: WeatherSerializer.new(parsed_forcast)
  end
end