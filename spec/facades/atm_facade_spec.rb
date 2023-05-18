require 'rails_helper'

RSpec.describe AtmFacade do
  describe 'initialize' do
    it 'exists and has a vendor_id' do
      atm = AtmFacade.new(1)

      expect(atm).to be_a(AtmFacade)
      expect(atm.vendor_id).to eq(1)
    end
  end

  describe 'closest_atms' do
    before(:each) do
      market = create(:market, lat: '35.077529', lon: '-106.600449')
      atms = AtmFacade.new(market.id).closest_atms
    end
    it 'returns an array of Atm objects' do
      expect(atm.closest_atms).to all be_a(Atm)
    end

    it 'sorts by distance from market' do
      
      expect(atm.closest_atms)
    end
  end
end