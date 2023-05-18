include Geocoder

class Atm
  attr_reader :name,
              :address,
              :lat,
              :lon

  def initialize(data)
    @name = 'ATM'
    @address = data.dig(:address, :freeformAddress)
    @lat = data.dig(:position, :lat)
    @lon = data.dig(:position, :lon)
  end

  def distance(market_id)
    market = Market.find(market_id)
    Geocoder::Calculations.distance_between([@lat, @lon], [market.lat, market.lon])
  end
end