class ForecastFacade

  def self.find_forecast(location)
    lat_lng = LocationService.find_coords(location)
    
    forecast_conn = Faraday.new("https://api.openweathermap.org") do |f|
    end
    
    forecast = forecast_conn.get("/data/2.5/onecall") do |f|
      f.params[:appid] = ENV['OPENWEATHER_API_KEY']
      f.params[:lat] = lat_lng[:lat] 
      f.params[:lon] = lat_lng[:lng]
    end
    # forecast = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |f|
    #   f.params[:lat] = lat_lng[:lat]
    #   f.params[:lon] = lat_lng[:lng]
    # end
    # require 'pry'; binding.pry

    parsed_forecast = JSON.parse(forecast.body, symbolize_names: true)

    Forecast.new(parsed_forecast)
  end
end