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
    require 'pry'; binding.pry
  end
end