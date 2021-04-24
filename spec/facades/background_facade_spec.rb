require 'rails_helper'

RSpec.describe 'background facade' do
  describe 'class methods' do
    describe '.get_background_image' do
      it 'returns a background poro given a location' do
        VCR.use_cassette('background_denver') do
          location = 'denver, co'

          result = BackgroundFacade.get_background_image(location)

          expect(result).to be_a(Background)
          expect(result.author).to_not eq(nil)
          expect(result.author_url).to_not eq(nil)
          expect(result.image_url).to_not eq(nil)
          expect(result.location).to_not eq(nil)
          expect(result.source).to_not eq(nil)
        end
      end
    end
  end
end