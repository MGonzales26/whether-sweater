class BackgroundService
  
  def self.get_background_image(location)
    result = conn.get('/search/photos') do |f|
      f.params['query'] = "#{location} landmark"
    end
    
    data = JSON.parse(result.body, symbolize_names: true)
    data[:results].first
  end
  
  private
  
  def self.conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
    end
  end
end