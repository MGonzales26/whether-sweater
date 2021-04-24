require 'rails_helper'

RSpec.describe 'forecast facade' do
  describe 'Class methods' do
    describe '.find_forecast' do
      it 'returns a forecast poro' do
        VCR.use_cassette('forecast_facade_denver') do
          location = 'denver, co'
          result = ForecastFacade.find_forecast(location)

          expect(result).to be_a(Forecast)
          expect(result.current_weather).to_not eq(nil)
          expect(result.daily_weather).to_not eq(nil)
          expect(result.hourly_weather).to_not eq(nil)
        end
      end
    end
  end
end