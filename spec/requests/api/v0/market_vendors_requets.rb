require 'rails_helper'

RSpec.describe 'Market Vendors API' do
  describe 'create market vendor' do
    it 'creates a market/vendor relationship' do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      mv_params = ({
                    "market_id": market_1.id,
                    "vendor_id": vendor_1.id
                  })
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:message)
      expect(data[:message]).to eq("Successfully added vendor to market")

      expect(MarketVendor.all.count).to eq(1)
      expect(MarketVendor.first.market_id).to eq(market_1.id)
      expect(MarketVendor.first.vendor_id).to eq(vendor_1.id)
    end
    it 'returns an error 404 message if market does not exist' do
      vendor_1 = create(:vendor)
      mv_params = ({
                    "market_id": 1,
                    "vendor_id": vendor_1.id
                  })
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Validation failed: Market must exist")
    end

    it 'returns an error 404 message if vendor does not exist' do
      market_1 = create(:market)
      mv_params = ({
                    "market_id": market_1.id,
                    "vendor_id": 1
                  })
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail]).to eq("Validation failed: Vendor must exist")
    end

    it 'returns an error 422 message if relationship already exists' do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      mv = MarketVendor.create!(market_id: market_1.id, vendor_id: vendor_1.id)

      mv_params = ({
                    "market_id": market_1.id,
                    "vendor_id": vendor_1.id
                  })
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail])
      .to eq("Validation failed: Market vendor asociation between market with market_id=#{market_1.id} and vendor_id=#{vendor_1.id} already exists")
    end
  end
end