class RoadTripService

  def self.get_road_trip(from, to)
    result = conn.get('/directions/v2/route') do |f|
      f.params[:from] = from
      f.params[:to] = to
    end
    JSON.parse(result.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end
end