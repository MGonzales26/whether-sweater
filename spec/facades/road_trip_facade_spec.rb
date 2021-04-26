require 'rails_helper'

RSpec.describe 'road trip facade' do
  describe 'happy path' do
    it 'returns a road trip poro given origin and destination' do
      VCR.use_cassette('Denver_to_Pueblo_facade') do
        from = "Denver,CO"
        to = "Pueblo,CO"

        road_trip = RoadTripFacade.find_road_trip(from, to)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to_not eq(nil)
        expect(road_trip.end_city).to_not eq(nil)
        expect(road_trip.travel_time).to_not eq(nil)
        expect(road_trip.weather_at_eta).to_not eq(nil)
      end
    end
    
    it 'for a NY to LA trip it displays the 40th hour weather' do
      VCR.use_cassette('NY_to_LA') do
        from = "New York,NY"
        to = "Los Angeles,CA"
        road_trip = RoadTripService.get_road_trip(from, to)
        destination_lat_lon = road_trip[:route][:locations][1][:displayLatLng]
        weather = ForecastService.find_forecast(destination_lat_lon)
        poro = RoadTrip.new(road_trip, weather)

        expect(poro.weather_at_eta[:temperature]).to eq(weather[:hourly][39][:temp])
        expect(poro.weather_at_eta[:conditions]).to eq(weather[:hourly][39][:weather][0][:description])
      end
    end

    it 'returns a road trip poro given origin and destination' do
      VCR.use_cassette('Denver_to_Pueblo_facade') do
        from = "Denver,CO"
        to = "Pueblo,CO"

        road_trip = RoadTripFacade.find_road_trip(from, to)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to_not eq(nil)
        expect(road_trip.end_city).to_not eq(nil)
        expect(road_trip.travel_time).to_not eq(nil)
        expect(road_trip.weather_at_eta).to_not eq(nil)
      end
    end
  end

  describe 'sad path' do
  end
end