require 'rails_helper' 

describe 'Markets API' do
  describe 'all markets' do
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
  end

  describe 'get one market' do
    it 'sends all market attributes if valid id is passed in' do
      markets = create_list(:market, 3)
      market = markets.first

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

  describe 'market search' do
    it 'searches by state, name, city' do
      create_list(:market, 3)
      market_1 = create(:market, name: "Nob Hill Growers' Market", city: "Albuquerque", state: "New Mexico" )

      get "/api/v0/markets/search?city=albuquerque&state=new Mexico&name=Nob hill"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)
      markets = data[:data]

      expect(markets.count).to eq 1

      market = markets[0]

      expect(market).to have_key(:id)
      expect(market[:id]).to be_a(String)
      expect(market).to have_key(:type)
      expect(market[:type]).to eq("market")
      
      attributes = market[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to eq("Nob Hill Growers' Market")

      expect(attributes).to have_key(:city)
      expect(attributes[:city]).to eq("Albuquerque")

      expect(attributes).to have_key(:state)
      expect(attributes[:state]).to eq("New Mexico")

      expect(attributes).to have_key(:vendor_count)
      expect(attributes[:vendor_count]).to eq(market_1.vendor_count)

    end

    it 'returns a 422 error if search is invalid' do
      get '/api/v0/markets/search?city=albuquerque'

      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:errors)
      expect(data[:errors][0]).to have_key(:detail)
      expect(data[:errors][0][:detail])
      .to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end
  end

  describe 'get cash dispensers near a market' do
    it 'returns a list of nearby atms sorted by distance' do
      market = create(:market, lat: '35.077529', lon: '-106.600449')
      get "/api/v0/markets/#{market.id}/nearest_atms"

      expect(response.status).to eq(200)
      # expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)
      atms = data[:data]

      expect(atms.count > 1).to be(true)

      atms.each do |atm|
        expect(atm).to have_key(:id)
        expect(atm).to have_key(:type)
        expect(atm[:type]).to eq('atm')

        attributes = atm[:attributes]

        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to eq("ATM")
        expect(attributes).to have_key(:address)
        expect(attributes).to have_key(:lat)
        expect(attributes).to have_key(:lon)
        expect(attributes).to have_key(:distance)
      end
      
      closest_atm = atms.first
      attributes = closest_atm[:attributes]
      expect(attributes[:address]).to eq("3902 Central Avenue Southeast, Albuquerque, NM 87108")
      expect(attributes[:lat]).to eq(35.079044)
      expect(attributes[:lon]).to eq(-106.60068)
      # expect(attributes[:distance]).to eq(0.10521432030421865)
    end
  end
end