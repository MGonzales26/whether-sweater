require 'rails_helper'

RSpec.describe 'forecast service' do
  describe 'class methods' do
    describe '.find_forecast' do
      it 'returns the forecast given coords' do
        VCR.use_cassette('forecast_for_denver') do
          lat_lng = {:lat=>39.738453, :lng=>-104.984853}

          result = ForecastService.find_forecast(lat_lng)

          expect(result).to be_a(Hash)
          expect(result).to have_key(:timezone)
          expect(result).to have_key(:current)
          expect(result[:current]).to be_a(Hash)
          expect(result).to have_key(:hourly)
          expect(result[:hourly]).to be_an(Array)
          expect(result).to have_key(:daily)
          expect(result[:daily]).to be_an(Array)
        end
      end
    end
  end
end