require 'rails_helper'

RSpec.describe 'road trip service' do
  describe 'class methods' do
    describe '.get_road_trip' do
      it 'returns the raw data needed to make a road trip poro' do
        VCR.use_cassette('Denver_to_Peublo_service') do
          from = "Denver,CO"
          to = "Pueblo,CO"
  
          road_trip = RoadTripService.get_road_trip(from, to)
          
          expect(result).to be_a(Hash)
          expect(result.count).to eq(1)
          expect(result).to have_key(:route)
          expect(result[:route]).to have_key(:formattedTime)
          expect(result[:route]).to have_key(:locations)
          expect(result[:route][:locations]).to be_an(Array)
          expect(result[:route][:locations].count).to eq(2)
          expect(result[:route][:locations][0]).to be_a(Hash) 
          expect(result[:route][:locations][0]).to have_key(:adminArea5)
          expect(result[:route][:locations][0][:adminArea5]).to be_a(String)
          expect(result[:route][:locations][0]).to have_key(:adminArea3) 
          expect(result[:route][:locations][0][:adminArea3]).to be_a(String)
          expect(result[:route][:locations][1]).to be_a(Hash) 
          expect(result[:route][:locations][1]).to have_key(:adminArea5)
          expect(result[:route][:locations][1][:adminArea5]).to be_a(String)
          expect(result[:route][:locations][1]).to have_key(:adminArea3) 
          expect(result[:route][:locations][1][:adminArea3]).to be_a(String)
        end
      end
    end
  end
end