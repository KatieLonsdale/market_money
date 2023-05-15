require 'rails_helper'

RSpec.describe Market do
  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'instance variables' do
    before(:each) do
      @market_1 = create(:market)
      @market_2 = create(:market)
      @market_3 = create(:market)
      @vendor_1 = create(:vendor)
      @vendor_2 = create(:vendor)
      @vendor_3 = create(:vendor)
      @vendor_4 = create(:vendor)
      @vendor_5 = create(:vendor)
      create_list(:market_vendor, 3, market_id: @market_1.id)
      create_list(:market_vendor, 4, market_id: @market_2.id)
    end
    describe 'vendor_count' do
      it 'returns the number of vendors associated with a market' do
        expect(@market_1.vendor_count).to eq(3)
        expect(@market_2.vendor_count).to eq(4)
        expect(@market_3.vendor_count).to eq(0)
      end
    end
  end
end