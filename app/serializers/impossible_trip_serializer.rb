class ImpossibleTripSerializer

  def self.impossible_trip(from, to)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: "#{from}",
          end_city: "#{to}",
          travel_time: 'impossible',
          weather_at_eta: {}
        }
      }
    }
  end
end