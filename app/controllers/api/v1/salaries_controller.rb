class Api::V1::SalariesController < ApplicationController

  def index
    coords = LocationService.find_coords(params[:destination])
    forecast = ForecastService.find_forecast(coords)
    conn = Faraday.new('https://api.teleport.org')
    salaries = conn.get("/api/urban_areas/slug:#{params[:destination]}/salaries")
    parsed_salaries = JSON.parse(salaries.body, symbolize_names: true)
    city_data = Salary.new(forecast, parsed_salaries, params[:destination])

    render json: SalariesSerializer.new(city_data)
  end
end