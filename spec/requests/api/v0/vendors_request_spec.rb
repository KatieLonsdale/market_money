require 'rails_helper'

RSpec.describe 'Vendors API' do
  describe 'get all vendors for market' do
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
        expect(attributes[:credit_accepted]).to be_in([true, false])
      end
    end
    it 'sends custom 404 message if invalid market id is passed in' do
      get "/api/v0/markets/1/vendors"

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Couldn't find Market with 'id'=1")
    end
  end

  describe 'get one vendor' do
    it 'returns vendor details for a given vendor' do
      vendors = create_list(:vendor, 2)
      vendor = vendors.first

      get "/api/v0/vendors/#{vendor.id}"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)
      vendor = data[:data]

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
      expect(attributes[:credit_accepted]).to be_in([true, false])
    end

    it 'sends custom 404 message if invalid vendor id is passed in' do
      get "/api/v0/vendors/1"

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=1")
    end
  end
end