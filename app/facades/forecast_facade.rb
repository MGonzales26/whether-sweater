class ForecastFacade

  def self.find_forecast(location)
    lat_lng = LocationService.find_coords(location)
    
    if lat_lng == {:lat=>39.390897, :lng=>-99.066067}
      "ERROR"
    else
    forecast = ForecastService.find_forecast(lat_lng)
    Forecast.new(forecast)
    end
  end
end