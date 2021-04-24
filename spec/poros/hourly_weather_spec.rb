require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'can be created' do
    VCR.use_cassette('forecast_facade_denver') do
      lat_lng = {:lat=>39.738453, :lng=>-104.984853}

      result = ForecastService.find_forecast(lat_lng)

      forecast = Forecast.new(result)
      
      forecast.hourly_weather.each do |hour|
        expect(hour).to be_an(HourlyWeather)
        expect(hour.time).to_not eq(nil)
        expect(hour.temperature).to_not eq(nil)
        expect(hour.conditions).to_not eq(nil)
        expect(hour.icon).to_not eq(nil)
      end
    end
  end
end