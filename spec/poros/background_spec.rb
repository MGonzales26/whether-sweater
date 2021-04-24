require 'rails_helper'

RSpec.describe Background do
  it 'can be created' do
    VCR.use_cassette('background_denver') do
      location = 'denver, co'
      image = BackgroundService.get_background_image(location)

      background = Background.new(image, location)

      expect(background).to be_a(Background)
      expect(background.author).to_not eq(nil)
      expect(background.author_url).to_not eq(nil)
      expect(background.image_url).to_not eq(nil)
      expect(background.location).to_not eq(nil)
      expect(background.source).to_not eq(nil)
    end
  end
end