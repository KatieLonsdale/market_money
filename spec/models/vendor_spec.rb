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
    it { should validate_inclusion_of(:credit_accepted).in_array([true, false]) }
    it { should validate_exclusion_of(:credit_accepted).in_array([nil]) }
  end

  describe 'class methods' do
    describe 'find_vendor' do
      it 'returns a vendor if id is valid' do
        vendor = create(:vendor)
        expect(Vendor.find_vendor(vendor.id)).to eq(vendor)
      end

      it 'returns a error_vendor is id is not valid' do
        vendor = Vendor.find_vendor(1)
        expect(vendor).to be_a ErrorVendor
        expect(vendor.error_message).to eq("Couldn't find Vendor with 'id'=1")
      end
    end
  end
end