require 'rails_helper'

RSpec.describe 'background service' do
  describe 'class methods' do
    describe '.get_background_image' do
      it 'returns a background image and credit given a location' do
        VCR.use_cassette('background_denver') do
          location = 'denver, co'

          result = BackgroundService.get_background_image(location)

          expect(result).to be_a(Hash)
          expect(result).to have_key(:links)
          expect(result[:links]).to have_key(:html)
          expect(result).to have_key(:user)
          expect(result[:user]).to have_key(:name)
          expect(result[:user]).to have_key(:links)
          expect(result[:user][:links]).to have_key(:html)
        end
      end
    end
  end
end