class Salary

  def initialize(forecast, salaries, location)
    @destination = location
    @forecast = get_weather(forecast)
    # require 'pry'; binding.pry
    @salaries = get_salaries(salaries)
  end

  def get_weather(forecast)
    {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp]} F"
    }
  end

  def get_salaries(salaries)
    tech_jobs = ["DATA-ANALYST", "DATA-SCIENTIST", "MOBILE-DEVELOPER", "QA-ENGINEER", "SOFTWARE-ENGINEER", "SYSTEMS-ADMINISTRATOR", "WEB-DEVELOPER"]
    salaries = salaries[:salaries]
    tech_salaries = []
    tech_jobs.each do |job|
      salaries.each do |salary|
        require 'pry'; binding.pry

      end
    end
  end
end