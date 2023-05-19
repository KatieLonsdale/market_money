require 'rails_helper'

RSpec.describe Vendor do
  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :contact_name}
    it { should validate_presence_of :contact_phone}
    it { should validate_exclusion_of(:credit_accepted).in_array([nil]) }
  end

  # describe 'class methods' do
  #   describe 'find_vendor' do
  #     it 'returns a vendor if id is valid' do
  #       vendor = create(:vendor)
  #       expect(Vendor.find_vendor(vendor.id)).to eq(vendor)
  #     end

  #     it 'returns an error_vendor if id is not valid' do
  #       vendor = Vendor.find_vendor(1)
  #       expect(vendor).to be_a ErrorVendor
  #       expect(vendor.error_message).to eq("Couldn't find Vendor with 'id'=1")
  #     end
  #   end

  #   describe 'new_vendor' do
  #     it 'returns a vendor if new record is valid' do
  #       params = ({
  #                   "name": "Buzzy Bees",
  #                   "description": "local honey and wax products",
  #                   "contact_name": "Berly Couwer",
  #                   "contact_phone": "8389928383",
  #                   "credit_accepted": false
  #                 })

  #       expect(Vendor.new_vendor(params)).to be_a Vendor
  #     end
  #     it 'returns an error_vendor if new record is not valid' do
  #       params = ({
  #         "name": "Buzzy Bees",
  #         "description": "local honey and wax products",
  #         "credit_accepted": false
  #       })

  #       vendor = Vendor.new_vendor(params)
  #       expect(vendor).to be_a ErrorVendor
  #       expect(vendor.error_message).to eq(["Contact name can't be blank", "Contact phone can't be blank"])
  #     end
  #   end
  # end

  describe 'instance methods' do
    describe 'states_sold_in' do
      it 'returns an array of the states of the markets it is associated with' do
        market_1 = create(:market, state: 'California')
        market_2 = create(:market, state: 'Wisconsin')
        market_3 = create(:market, state: 'Colorado')
        vendor_1 = create(:vendor)
        [market_1, market_2, market_3].each do |market|
          create(:market_vendor, market_id: market.id, vendor_id: vendor_1.id)
        end

        expect(vendor_1.states_sold_in).to eq(['California', 'Colorado', 'Wisconsin'])
      end

      it 'does not return duplicates' do
        market_1 = create(:market, state: 'California')
        market_2 = create(:market, state: 'Wisconsin')
        market_3 = create(:market, state: 'California')
        vendor_1 = create(:vendor)
        [market_1, market_2, market_3].each do |market|
          create(:market_vendor, market_id: market.id, vendor_id: vendor_1.id)
        end

        expect(vendor_1.states_sold_in).to eq(['California', 'Wisconsin'])
      end
    end

  #   describe 'update_vendor' do
  #     before(:each) do
  #       @vendor = create(:vendor)
  #     end
  #     it 'returns a vendor if update is valid' do
  #       params = ({
  #                   "contact_name": "Kimberly Couwer",
  #                   "credit_accepted": false
  #                 })

  #       expect(@vendor.update_vendor(params)).to eq(@vendor)
  #     end
  #     it 'returns an error_vendor if update is not valid' do
  #       params = ({
  #                   "contact_name": "",
  #                   "credit_accepted": false
  #                 })

  #       vendor = @vendor.update_vendor(params)
  #       expect(vendor).to be_a ErrorVendor
  #       expect(vendor.error_message).to eq(["Contact name can't be blank"])
  #     end
  #   end
  end
end