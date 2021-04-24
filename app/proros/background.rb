class Background
    attr_reader :source,
                :location,
                :image_url,
                :author,
                :author_url

  def initialize(data, location)
    @source = 'unsplash.com'
    @location = location
    @image_url = data[:links][:html]
    @author = data[:user][:name]
    @author_url = data[:user][:links][:html]
  end
end