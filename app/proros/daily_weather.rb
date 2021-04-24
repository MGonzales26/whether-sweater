class DailyWeather
  include Formatter

  attr_reader :date,
              :sunrise,
              :sunset,
              :min_temp,
              :max_temp,
              :conditions,
              :icon

  def initialize(data, timezone_offset)
    @date = local_time(data[:dt], timezone_offset).split(' ').first
    @sunrise = local_time(data[:sunrise], timezone_offset)
    @sunset = local_time(data[:sunset], timezone_offset)
    @min_temp = data[:temp][:min]
    @max_temp = data[:temp][:max]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end