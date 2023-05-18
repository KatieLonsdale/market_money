class AtmService
  def self.nearby_atms(lat, lon)
    get_url("https://api.tomtom.com/search/2/categorySearch/automatic_teller_machine.json?key=#{ENV['TOMTOM_API_KEY']}&lat=#{lat}&lon=#{lon}")
  end

  def self.get_url(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end