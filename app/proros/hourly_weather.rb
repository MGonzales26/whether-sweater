class HourlyWeather < Forecast
  include Formatter

  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data, timezone_offset)
    @time = local_time(data[:dt], timezone_offset).split(' ')[1]
    @temperature = data[:temp]
    @conditions = get_conditions(data)
    @icon = get_icon(data)
  end
end