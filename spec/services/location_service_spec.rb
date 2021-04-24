require 'rails_helper'

RSpec.describe 'location service' do
  describe 'class methods' do
    describe '.find_coords' do
      it 'returns a hash or lat and long coordinates' do
        location = 'denver, co'
        result = LocationService.find_coords(location)

        expect(result).to be_a(Hash)
        expect(result).to have_key(:lat)
        expect(result[:lat]).to be_a(Float)
        expect(result).to have_key(:lng)
        expect(result[:lng]).to be_a(Float)
      end
    end
  end
end