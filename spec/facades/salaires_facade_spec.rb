require 'rails_helper'

RSpec.describe 'salaries facade' do
  it 'gives the controller a saraly poro' do
    VCR.use_cassette('salary_facade') do
      location = "chicago"
  
      salaries = SalariesFacade.get_salaries(location)
  
      expect(salaries).to be_a(Salary)
      expect(salaries.destination).to_not eq(nil)
      expect(salaries.forecast).to_not eq(nil)
      expect(salaries.salaries).to_not eq(nil)
    end
  end
end