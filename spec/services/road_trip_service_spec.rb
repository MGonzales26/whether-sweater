require 'rails_helper'

RSpec.describe 'road trip service' do
  describe 'class methods' do
    describe '.get_road_trip' do
      it 'returns the raw data needed to make a road trip poro' do
        VCR.use_cassette('Denver_to_Peublo_service') do
          from = "Denver,CO"
          to = "Pueblo,CO"
  
          road_trip = RoadTripService.get_road_trip(from, to)
          
          expect(road_trip).to be_a(Hash)
          expect(road_trip.count).to eq(2)
          expect(road_trip).to have_key(:route)
          expect(road_trip[:route]).to have_key(:formattedTime)
          expect(road_trip[:route]).to have_key(:locations)
          expect(road_trip[:route][:locations]).to be_an(Array)
          expect(road_trip[:route][:locations].count).to eq(2)
          expect(road_trip[:route][:locations][0]).to be_a(Hash) 
          expect(road_trip[:route][:locations][0]).to have_key(:adminArea5)
          expect(road_trip[:route][:locations][0][:adminArea5]).to be_a(String)
          expect(road_trip[:route][:locations][0]).to have_key(:adminArea3) 
          expect(road_trip[:route][:locations][0][:adminArea3]).to be_a(String)
          expect(road_trip[:route][:locations][1]).to be_a(Hash) 
          expect(road_trip[:route][:locations][1]).to have_key(:adminArea5)
          expect(road_trip[:route][:locations][1][:adminArea5]).to be_a(String)
          expect(road_trip[:route][:locations][1]).to have_key(:adminArea3) 
          expect(road_trip[:route][:locations][1][:adminArea3]).to be_a(String)
        end
      end
    end
  end
end