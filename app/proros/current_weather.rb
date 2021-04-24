class CurrentWeather
  include Formatter
  
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data, offset)
    @datetime = local_time(data[:dt], offset)
    @sunrise = local_time(data[:sunrise], offset)
    @sunset = local_time(data[:sunset], offset)
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]   
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end