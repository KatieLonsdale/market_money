require 'rails_helper' 

describe 'Markets API' do
  it 'sends a list of all markets' do
    create_list(:market, 4)
    
    get '/api/v0/markets'

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)
    markets = data[:data]


    expect(markets.count).to eq 4

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_a(String)
      expect(market).to have_key(:type)
      expect(market[:type]).to be_a(String)
      
      attributes = market[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:street)
      expect(attributes[:street]).to be_a(String)

      expect(attributes).to have_key(:city)
      expect(attributes[:city]).to be_a(String)

      expect(attributes).to have_key(:county)
      expect(attributes[:county]).to be_a(String)

      expect(attributes).to have_key(:state)
      expect(attributes[:state]).to be_a(String)

      expect(attributes).to have_key(:zip)
      expect(attributes[:zip]).to be_a(String)

      expect(attributes).to have_key(:lat)
      expect(attributes[:lat]).to be_a(String)

      expect(attributes).to have_key(:lon)
      expect(attributes[:lon]).to be_a(String)

      expect(attributes).to have_key(:vendor_count)
      expect(attributes[:vendor_count]).to be_a(Integer)
    end
  end

  it 'sends all market attributes if valid id is passed in' do
    market = create(:market)

    get "/api/v0/markets/#{market.id}"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)
    market = data[:data]

    expect(data.count).to eq 1

    expect(market).to have_key(:id)
    expect(market[:id]).to be_a(String)
    expect(market).to have_key(:type)
    expect(market[:type]).to be_a(String)
    
    attributes = market[:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:street)
    expect(attributes[:street]).to be_a(String)

    expect(attributes).to have_key(:city)
    expect(attributes[:city]).to be_a(String)

    expect(attributes).to have_key(:county)
    expect(attributes[:county]).to be_a(String)

    expect(attributes).to have_key(:state)
    expect(attributes[:state]).to be_a(String)

    expect(attributes).to have_key(:zip)
    expect(attributes[:zip]).to be_a(String)

    expect(attributes).to have_key(:lat)
    expect(attributes[:lat]).to be_a(String)

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to be_a(String)

    expect(attributes).to have_key(:vendor_count)
    expect(attributes[:vendor_count]).to be_a(Integer)
  end

  it 'sends custom 404 message if invalid market id is passed in' do
    get "/api/v0/markets/1"

    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to have_key(:errors)
    expect(data[:errors][0]).to have_key(:detail)
    expect(data[:errors][0][:detail]).to eq("Couldn't find Market with 'id'=1")
  end
end