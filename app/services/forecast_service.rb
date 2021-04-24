class ForecastService

  def self.find_forecast(coords)
    forecast = conn.get("/data/2.5/onecall") do |f|
      f.params[:lat] = coords[:lat] 
      f.params[:lon] = coords[:lng]
    end
    
    JSON.parse(forecast.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new("https://api.openweathermap.org") do |f|
      f.params[:appid] = ENV['OPENWEATHER_API_KEY']
    end
  end
end