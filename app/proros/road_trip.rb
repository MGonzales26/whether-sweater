class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  include Formatter

  def initialize(trip, weather)
    @timezone_offset = weather[:timezone_offset]
    @start_city = find_start_city(trip)
    @end_city = find_end_city(trip)
    @time = trip[:route][:formattedTime]
    @split_travel_time = split_travel_time
    @travel_time = travel_time
    @weather_at_eta = find_weather_at_eta(weather)
  end

  def find_start_city(trip)
    "#{trip[:route][:locations][0][:adminArea5]}, #{trip[:route][:locations][0][:adminArea3]}"
  end

  def find_end_city(trip)
    "#{trip[:route][:locations][1][:adminArea5]}, #{trip[:route][:locations][1][:adminArea3]}"
  end

  def travel_time
    "#{@split_travel_time[0]} #{'hour'.pluralize(@split_travel_time[0])}, #{@split_travel_time[1]} #{'minute'.pluralize(@split_travel_time[1])}"
  end

  def split_travel_time
    @time.split(':').map(&:to_i)
  end

  def find_weather_at_eta(weather)
    total_travel_hours = @split_travel_time[0]
    arrival_weather = weather[:hourly][total_travel_hours - 1]
    { 
      temperature: arrival_weather[:temp],
      conditions:  arrival_weather[:weather].first[:description]
    }
  end
end