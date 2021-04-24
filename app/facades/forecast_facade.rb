class ForecastFacade

  def self.find_forecast(location)
    location_conn = Faraday.new("http://www.mapquestapi.com/geocoding/v1/address")
    location = location_conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = location
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
    parsed = JSON.parse(location.body, symbolize_names: true)
    lat_lng = parsed[:results].first[:locations].first[:latLng]

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