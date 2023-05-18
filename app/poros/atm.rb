class Atm
  attr_reader :name,
              :address,
              :lat,
              :lon,
              :distance

  def initialize(data)
    @name = 'ATM'
    @address = data.dig(:address, :freeformAddress)
    @lat = data.dig(:position, :lat)
    @lon = data.dig(:position, :lon)
    @distance = data[:dist]
  end
end