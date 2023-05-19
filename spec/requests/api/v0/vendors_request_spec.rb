require 'rails_helper'

RSpec.describe 'Vendors API' do
  describe 'get all vendors for market' do
    it 'returns all vendors for a given market' do
      market_1 = create(:market)
      market_2 = create(:market)
      vendor_1 = create(:vendor)
      create(:market_vendor, vendor_id: vendor_1.id, market_id: market_1.id)
      m1_vendors = create_list(:market_vendor, 3, market_id: market_1.id)
      m2_vendors = create_list(:market_vendor, 2, market_id: market_2.id)

      get "/api/v0/markets/#{market_1.id}/vendors"

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      vendors = data[:data]
      expect(vendors.count).to eq(4)

      vendors.each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor).to have_key(:type)
        
        attributes = vendor[:attributes]
        expect(attributes).to have_key(:name)
        expect(attributes).to have_key(:description)
        expect(attributes).to have_key(:contact_name)
        expect(attributes).to have_key(:contact_phone)
        expect(attributes).to have_key(:credit_accepted)
        expect(attributes[:credit_accepted]).to be_in([true, false])
      end
      
      vendor = vendors.first
      attributes = vendor[:attributes]

      expect(attributes[:name]).to eq(vendor_1.name)
      expect(attributes[:description]).to eq(vendor_1.description)
      expect(attributes[:contact_name]).to eq(vendor_1.contact_name)
      expect(attributes[:contact_phone]).to eq(vendor_1.contact_phone)
      expect(attributes[:credit_accepted]).to eq(vendor_1.credit_accepted)
    end
    it 'sends 404 message if invalid market id is passed in' do
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
      vendor_1 = vendors.first

      get "/api/v0/vendors/#{vendor_1.id}"

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      vendor = data[:data]

      expect(data.count).to eq(1)

      expect(vendor).to have_key(:id)
      expect(vendor).to have_key(:type)

      attributes = vendor[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to eq(vendor_1.name)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to eq(vendor_1.description)

      expect(attributes).to have_key(:contact_name)
      expect(attributes[:contact_name]).to eq(vendor_1.contact_name)

      expect(attributes).to have_key(:contact_phone)
      expect(attributes[:contact_phone]).to eq(vendor_1.contact_phone)

      expect(attributes).to have_key(:credit_accepted)
      expect(attributes[:credit_accepted]).to eq(vendor_1.credit_accepted)
    end

    it 'sends 404 message if invalid vendor id is passed in' do
      get "/api/v0/vendors/1"

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=1")
    end
  end

  describe 'create a vendor' do
    it 'returns the new vendor details if request is valid' do
      vendor_params = ({
                        "name": "Buzzy Bees",
                        "description": "local honey and wax products",
                        "contact_name": "Berly Couwer",
                        "contact_phone": "8389928383",
                        "credit_accepted": false
                      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      new_vendor = Vendor.last

      expect(new_vendor.name).to eq(vendor_params[:name])
      expect(new_vendor.description).to eq(vendor_params[:description])
      expect(new_vendor.contact_name).to eq(vendor_params[:contact_name])
      expect(new_vendor.contact_phone).to eq(vendor_params[:contact_phone])
      expect(new_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])

      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)
      vendor = data[:data]

      expect(data.count).to eq(1)

      expect(vendor).to have_key(:id)
      expect(vendor).to have_key(:type)

      attributes = vendor[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to eq(new_vendor.name)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to eq(new_vendor.description)

      expect(attributes).to have_key(:contact_name)
      expect(attributes[:contact_name]).to eq(new_vendor.contact_name)

      expect(attributes).to have_key(:contact_phone)
      expect(attributes[:contact_phone]).to eq(new_vendor.contact_phone)

      expect(attributes).to have_key(:credit_accepted)
      expect(attributes[:credit_accepted]).to eq(new_vendor.credit_accepted)
    end

    it 'returns an error 400 message if not all attributes are provided in request' do
      vendor_params = ({
                        "name": "Buzzy Bees",
                        "description": "local honey and wax products",
                        "credit_accepted": false
                      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
      expect(response.status).to eq(400)
      
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).
      to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
    end
  end

  describe 'update a vendor' do
    it 'returns updated vendor details' do
      vendor_1 = create(:vendor)

      vendor_params = ({
                        "contact_name": "Kimberly Couwer",
                        "credit_accepted": false
                      })
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v0/vendors/#{vendor_1.id}", headers: headers, params: JSON.generate(vendor: vendor_params)
      
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      vendor = data[:data]
      
      expect(data.count).to eq(1)

      expect(vendor).to have_key(:id)
      expect(vendor).to have_key(:type)

      attributes = vendor[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to eq(vendor_1.name)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to eq(vendor_1.description)

      expect(attributes).to have_key(:contact_name)
      expect(attributes[:contact_name]).to eq("Kimberly Couwer")

      expect(attributes).to have_key(:contact_phone)
      expect(attributes[:contact_phone]).to eq(vendor_1.contact_phone)

      expect(attributes).to have_key(:credit_accepted)
      expect(attributes[:credit_accepted]).to eq(false)
    end

    it 'returns an error 404 message if vendor id is invalid' do
      patch "/api/v0/vendors/1"

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=1")
    end

    it 'returns an error 400 message if a field is blank' do
      vendor_1 = create(:vendor)
      
      vendor_params = ({
                        "contact_name": "",
                        "credit_accepted": false
                      })
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v0/vendors/#{vendor_1.id}", headers: headers, params: JSON.generate(vendor: vendor_params)
      expect(response.status).to eq(400)
      
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).
      to eq("Validation failed: Contact name can't be blank")
    end
  end

  describe 'delete a vendor' do
    it 'deletes given vendor and their market vendors' do
      vendor_1 = create(:vendor)
      create(:market_vendor, vendor_id: vendor_1.id)
      delete "/api/v0/vendors/#{vendor_1.id}"

      expect(response.status).to eq(204)
      expect(Vendor.all.count).to eq(0)
      expect(MarketVendor.all.count).to eq(0)
      expect(Market.all.count).to eq(1)
    end
    it 'returns an error 404 message if vendor id is invalid' do
      delete "/api/v0/vendors/1"

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=1")
    end
  end
end