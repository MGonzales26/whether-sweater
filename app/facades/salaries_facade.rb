class SalariesFacade

  def self.get_salaries(location)
    coords = LocationService.find_coords(location)
    forecast = ForecastService.find_forecast(coords)
    conn = Faraday.new('https://api.teleport.org')
    salaries = conn.get("/api/urban_areas/slug:#{location}/salaries")
    parsed_salaries = JSON.parse(salaries.body, symbolize_names: true)
    Salary.new(forecast, parsed_salaries, location)
  end
end