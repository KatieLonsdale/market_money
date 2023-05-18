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
end