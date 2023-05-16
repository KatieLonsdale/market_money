require 'rails_helper'

RSpec.describe 'Vendors API' do
  it 'returns all vendors for a given market' do
    market_1 = create(:market)
    market_2 = create(:market)
    m1_vendors = create_list(:market_vendor, 3, market_id: market_1.id)
    m2_vendors = create_list(:market_vendor, 2, market_id: market_2.id)

    get "/api/v0/markets/#{market_1.id}/vendors"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)
    vendors = data[:data]

    vendors.each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_a(String)
      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to be_a(String)
      
      attributes = vendor[:attributes]
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)

      expect(attributes).to have_key(:contact_name)
      expect(attributes[:contact_name]).to be_a(String)

      expect(attributes).to have_key(:contact_phone)
      expect(attributes[:contact_phone]).to be_a(String)

      expect(attributes).to have_key(:credit_accepted)
      expect(attributes[:credit_accepted]).to eq(true || false)
    end
  end
end