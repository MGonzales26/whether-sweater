class Forecast

  attr_reader :timezone_offset,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @timezone_offset = data[:timezone_offset]
    @current_weather = data[:current]
    @daily_weather = data[:daily] #is an array
    @hourly_weather = data[:hourly] #is an array
    # @daily = daily_weather
    # @current = current_weather
    # @hourly = hourly_weather
  end

  def current_weather
    CurrentWeather.new(@current_weather, @timezone_offset)
  end

  def daily_weather
    @daily_weather.first(5).map do |day|
      DailyWeather.new(day, @timezone_offset)
    end
  end

  def hourly_weather
    @hourly_weather.first(8).map do |hour|
      HourlyWeather.new(hour, @timezone_offset)
    end
  end

  def get_conditions(data)
    data[:weather].first[:description]
  end

  def get_icon(data)
    data[:weather].first[:icon]
  end
end