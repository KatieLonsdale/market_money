require 'rails_helper'

RSpec.describe MarketVendor do
  describe 'relationships' do
    it { should belong_to :market }
    it { should belong_to :vendor }
  end

  describe 'validations' do
    it {should validate_presence_of :market_id}
    it {should validate_presence_of :vendor_id}

    describe 'unique_market_vendor' do
      it 'adds an error message if market_vendor already exists' do
        market = create(:market)
        vendor = create(:vendor)
        mv = MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)

        invalid_mv = MarketVendor.create(market_id: market.id, vendor_id: vendor.id)
        expect(invalid_mv.valid?).to be false
        message = "Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists"
        expect(invalid_mv.errors.full_messages.include?(message)).to be true
      end
    end
  end

  describe 'class methods' do
    describe 'find_mv' do
      it 'finds market_vendor based on market and vendor ids' do
        market = create(:market)
        vendor = create(:vendor)
        mv = MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)

        params = {market_id: market.id, vendor_id: vendor.id}
        expect(MarketVendor.find_mv(params)).to eq(mv)
      end
    end
  end

  describe 'instance methods' do
    describe 'exists?' do
      it 'checks if an unsaved record is a duplicate' do
        market = create(:market)
        vendor = create(:vendor)
        mv = MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
        expect(mv.exist?).to be true
      end
    end
  end
end