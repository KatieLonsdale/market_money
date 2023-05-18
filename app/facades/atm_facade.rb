class AtmFacade
  attr_reader :vendor_id

  def initialize(vendor_id)
    @vendor_id = vendor_id
  end

  def closest_atms
    atms = AtmService.nearby_atms(find_lat, find_lon)
    atms = atms[:results].map!{ |atm| Atm.new(atm) }
    atms.sort_by{ |atm| atm.distance }
  end

  def find_lat
    Market.find(@vendor_id).lat
  end

  def find_lon
    Market.find(@vendor_id).lon
  end
end