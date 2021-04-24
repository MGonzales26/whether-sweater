class Forecast

  def initialize(data)
    @current_weather = data[:current]
    @daily_weather = data[:daily] #is an array
    @hourly_weather = data[:hourly] #is an array
    require 'pry'; binding.pry
  end

  def current_weather(@current_weather)
  end

  def daily_weather(@daily_weather)
  end

  def hourly_weather(@hourly_weather)
  end
end