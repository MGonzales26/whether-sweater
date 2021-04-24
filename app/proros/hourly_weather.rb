class HourlyWeather
  include Formatter

  def initialize(data, timezone_offset)
    @time = local_time(data[:dt], timezone_offset).split(' ')[1]
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end