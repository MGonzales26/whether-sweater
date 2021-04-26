require 'rails_helper'

RSpec.describe 'salaries service' do
  it 'returns all of the raw data to the facade that is needed' do
    VCR.use_cassette('salaries_service') do
      location = 'chicago'

      results = SalariesService.find_salaries(location)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:salaries)
      expect(results[:salaries]).to be_an(Array)

      results[:salaries].each do |salary|
        expect(salary).to have_key(:job)
        expect(salary[:job]).to be_a(Hash)
        expect(salary[:job]).to have_key(:id)
        expect(salary[:job]).to have_key(:title)
        expect(salary).to have_key(:salary_percentiles)
        expect(salary[:salary_percentiles]).to be_a(Hash)
        expect(salary[:salary_percentiles]).to have_key(:percentile_25)
        expect(salary[:salary_percentiles]).to have_key(:percentile_75)
      end
    end
  end
end