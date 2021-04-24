class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  set_type 'image'
  attribute :image do |image|
    {
      location: image.location,
      image_url: image.image_url,
      credit: {
        source: image.source,
        author: image.author,
        authorUrl: image.author_url
      }
    }
  end
end