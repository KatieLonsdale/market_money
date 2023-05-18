class AtmFacade
  attr_reader :vendor_id

  def initialize(vendor_id)
    @vendor_id = vendor_id
  end

  def closest_atms
    service = AtmService.new
    atms = service.nearby_atms(@vendor_id)[:results]
    atms.map do |atm|
      Atm.new(atm)
    end
  end
end