require 'rails_helper'

RSpec.describe DailyWeather do
  it 'can be created' do
    VCR.use_cassette('forecast_facade_denver') do
      lat_lng = {:lat=>39.738453, :lng=>-104.984853}

      result = ForecastService.find_forecast(lat_lng)

      forecast = Forecast.new(result)
      
      forecast.daily_weather.each do |day|
        expect(day).to be_an(DailyWeather)
        expect(day.date).to_not eq(nil)
        expect(day.sunrise).to_not eq(nil)
        expect(day.sunset).to_not eq(nil)
        expect(day.min_temp).to_not eq(nil)
        expect(day.max_temp).to_not eq(nil)
        expect(day.conditions).to_not eq(nil)
        expect(day.icon).to_not eq(nil)
      end
    end
  end
end