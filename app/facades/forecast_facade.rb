class ForecastFacade

  def self.find_forecast(location)
    lat_lng = LocationService.find_coords(location)
    forecast = ForecastService.find_forecast(lat_lng)
    Forecast.new(forecast)
  end
end