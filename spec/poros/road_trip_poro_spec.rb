require 'rails_helper'

RSpec.describe 'road trip poro' do
  it 'can be created' do
    VCR.use_cassette('roadtrip_poro') do
      from = "Denver,CO"
      to = "Pueblo,CO"
      trip = RoadTripService.get_road_trip(from, to)
      destination_lat_lon = trip[:route][:locations][1][:displayLatLng]
      weather = ForecastService.find_forecast(destination_lat_lon)
      road_trip = RoadTrip.new(trip, weather)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to_not eq(nil)
      expect(road_trip.end_city).to_not eq(nil)
      expect(road_trip.travel_time).to_not eq(nil)
      expect(road_trip.weather_at_eta).to_not eq(nil)
    end
  end
end