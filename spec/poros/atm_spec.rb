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
end