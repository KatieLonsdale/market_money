require 'rails_helper'

RSpec.describe AtmFacade do
  describe 'initialize' do
    it 'exists and has a vendor_id' do
      atm_facade = AtmFacade.new(1)

      expect(atm_facade).to be_a(AtmFacade)
      expect(atm_facade.vendor_id).to eq(1)
    end
  end

  describe 'closest_atms' do
    it 'returns an array of Atm objects' do
      market = create(:market, lat: '35.077529', lon: '-106.600449')
      atm_facade = AtmFacade.new(market.id)
      expect(atm_facade.closest_atms).to all be_a(Atm)
    end
  end

  describe 'find_lat' do
    it 'returns the latitude of a market with a given id' do
      market = create(:market, lat: '35.077529', lon: '-106.600449')
      atm_facade = AtmFacade.new(market.id)
      expect(atm_facade.find_lat).to eq('35.077529')
    end
  end
  describe 'find_lon' do
    it 'returns the longitude of a market with a given id' do
      market = create(:market, lat: '35.077529', lon: '-106.600449')
      atm_facade = AtmFacade.new(market.id)
      expect(atm_facade.find_lon).to eq('-106.600449')
    end
  end
end