require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'can be created' do
    VCR.use_cassette('forecast_facade_denver') do
      lat_lng = {:lat=>39.738453, :lng=>-104.984853}

      result = ForecastService.find_forecast(lat_lng)

      forecast = Forecast.new(result)
      
      current = forecast.current_weather
      expect(current).to be_a(CurrentWeather)
      expect(current.datetime).to_not eq(nil)
      expect(current.sunrise).to_not eq(nil)
      expect(current.sunrise).to_not eq(nil)
      expect(current.temperature).to_not eq(nil)
      expect(current.feels_like).to_not eq(nil)
      expect(current.humidity).to_not eq(nil)
      expect(current.uvi).to_not eq(nil)
      expect(current.visibility).to_not eq(nil)
      expect(current.conditions).to_not eq(nil)
      expect(current.icon).to_not eq(nil)
    end
  end
end