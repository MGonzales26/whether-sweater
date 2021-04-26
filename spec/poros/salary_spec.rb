require 'rails_helper'

RSpec.describe 'salary poro' do
  describe 'happy path' do
    it 'creates a salary poro give the raw data' do
      VCR.use_cassette('salary_poro') do
        location = 'chicago'
        coords = LocationService.find_coords(location)
        forecast = ForecastService.find_forecast(coords)
        salaries = SalariesService.find_salaries(location)
  
        result = Salary.new(forecast, salaries, location)
  
        expect(result).to be_a(Salary)
        expect(result.destination).to_not eq(nil)
        expect(result.forecast).to_not eq(nil)
        expect(result.salaries).to_not eq(nil)
      end
    end
  end
end