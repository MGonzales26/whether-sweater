require 'rails_helper'

RSpec.describe 'road trip facade' do
  describe 'class methods' do
    describe '.find_road_trip' do
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
  end
end