class BackgroundFacade

  def self.get_background_image(location)
    image = BackgroundService.get_background_image(location)
    Background.new(image, location)
  end
end