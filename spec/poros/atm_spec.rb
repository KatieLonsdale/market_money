require 'rails_helper'

RSpec.describe Atm do
  describe 'initialize' do
    it 'exists and has attributes' do
      atm = Atm.new(mock_atm)
      expect(atm).to be_a(Atm)
      expect(atm.name).to eq('ATM')
      expect(atm.address).to eq('820 Route 66, Moriarty, NM 87035')
      expect(atm.lat).to eq(35.004683)
      expect(atm.lon).to eq(-106.029628)
    end
  end

  describe 'distance' do
    it 'returns the distance of an atm from a market' do
      market = create(:market, lat: '35.077529', lon: '-106.600449')
      atm = Atm.new(mock_atm)

      expect(atm.distance(market.id)).to eq(32.680908220435576)
    end
  end
end