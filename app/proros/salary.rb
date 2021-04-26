class Salary
  include ActionView::Helpers::NumberHelper

  attr_reader :destination,
              :forecast,
              :salaries

  def initialize(forecast, salaries, location)
    @destination = location
    @forecast = get_weather(forecast)
    @salaries = get_salaries(salaries)
  end

  def get_weather(forecast)
    {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp].to_i} F"
    }
  end

  def get_salaries(salaries)
    tech_jobs = ["DATA-ANALYST", "DATA-SCIENTIST", "MOBILE-DEVELOPER", "QA-ENGINEER", "SOFTWARE-ENGINEER", "SYSTEMS-ADMINISTRATOR", "WEB-DEVELOPER"]
    salaries = salaries[:salaries]
    tech_salaries = []
    tech_jobs.each do |job|
      salaries.each do |salary|
        tech_salaries << salary_info(salary) if job == salary[:job][:id]
      end
    end
    tech_salaries
  end

  def salary_info(salary)
    {
      title: salary[:job][:title],
      min: number_to_currency(salary[:salary_percentiles][:percentile_25].round(2)),
      max: number_to_currency(salary[:salary_percentiles][:percentile_75].round(2))
    }
  end
end