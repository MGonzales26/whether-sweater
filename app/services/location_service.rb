class LocationService

  def self.find_coords(location)
    location = conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = location
    end
    parsed = JSON.parse(location.body, symbolize_names: true)
    parsed[:results].first[:locations].first[:latLng]
  end

  private

  def self.conn
    Faraday.new("http://www.mapquestapi.com/geocoding/v1/address") do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end
end