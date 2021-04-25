class Api::V1::RoadTripController < ApplicationController

  def create
    conn = Faraday.new('http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end

    result = conn.get('/directions/v2/route') do |f|
      f.params[:from] = trip_params[:origin]
      f.params[:to] = trip_params[:destination]
    end

    parsed = JSON.parse(result.body, symbolize_names: true)
    
    destination_lat_lon = parsed[:route][:locations][1][:displayLatLng]
    weather = ForecastService.find_forecast(destination_lat_lon)
    road_trip = RoadTrip.new(parsed, weather)
    # require 'pry'; binding.pry
    render json: RoadTripSerializer.new(road_trip)
  end
  private

  def trip_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end