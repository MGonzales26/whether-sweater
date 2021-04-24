require 'rails_helper'

RSpec.describe Forecast do
  it 'can be created' do
    VCR.use_cassette('forecast_facade_denver') do
      lat_lng = {:lat=>39.738453, :lng=>-104.984853}

      result = ForecastService.find_forecast(lat_lng)

      forecast = Forecast.new(result)
      
      expect(forecast).to be_a(Forecast)
      expect(forecast.timezone_offset).to_not eq(nil)
      expect(forecast.current_weather).to_not eq(nil)
      expect(forecast.daily_weather).to_not eq(nil)
      expect(forecast.hourly_weather).to_not eq(nil)
    end
  end
end