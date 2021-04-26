class SalariesFacade

  def self.get_salaries(location)
    coords = LocationService.find_coords(location)
    forecast = ForecastService.find_forecast(coords)
    salaries = SalariesService.find_salaries(location)
    Salary.new(forecast, salaries, location)
  end
end