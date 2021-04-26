class RoadTripFacade
  
  def self.find_road_trip(from, to)

    road_trip = RoadTripService.get_road_trip(from, to)
    if road_trip[:info][:statuscode] == 402
      "ERROR"
    else
      destination_lat_lon = road_trip[:route][:locations][1][:displayLatLng]
      weather = ForecastService.find_forecast(destination_lat_lon)
      RoadTrip.new(road_trip, weather)
    end
  end
end