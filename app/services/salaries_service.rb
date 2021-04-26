class SalariesService

  def self.find_salaries(location)
    salaries = conn.get("/api/urban_areas/slug:#{location}/salaries")
    JSON.parse(salaries.body, symbolize_names: true)
  end
  
  private
  
  def self.conn
    Faraday.new('https://api.teleport.org')
  end
end