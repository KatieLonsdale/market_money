require 'rails_helper'

RSpec.describe Market do
  describe 'relationships' do
    it { should have_many :market_vendors }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'class methods' do
    describe 'find_market' do
      it 'returns a market if id is valid' do
        market = create(:market)
        expect(Market.find_market(market.id)).to eq(market)
      end

      it 'returns a error_market is id is not valid' do
        market = Market.find_market(1)
        expect(market).to be_a ErrorMarket
        expect(market.error_message).to eq("Couldn't find Market with 'id'=1")
      end
    end

    describe 'search' do
      it 'returns an array of markets that meet search criteria' do
        nm_ab_markets = create_list(:market, 3, city: "Albuquerque", state: "New Mexico")
        nm_sf_markets = create_list(:market, 1, city: "Santa Fe", state: "New Mexico")
        co_markets = create_list(:market, 2, state: "Colorado")
        params = ({state: "New Mexico", city: nm_ab_markets.first.city, name: nm_ab_markets.first.name})
        expect(Market.search(params)).to eq([nm_ab_markets.first])

        params_2 = ({state: "New Mexico", city: "Albuquerque"})
        expect(Market.search(params_2)).to eq(nm_ab_markets)

        params_3 = ({state: "New Mexico"})
        expect(Market.search(params_3)).to eq((nm_ab_markets + nm_sf_markets).flatten)

        params_4 = ({name: nm_sf_markets.first.name.to_s})
        expect(Market.search(params_4)).to eq([nm_sf_markets.first])
      end
      it 'is case insensitive' do
        market = create(:market, state: 'New Mexico')

        params = ({state: "new Mexico", city: market.city, name: market.name})
        expect(Market.search(params)).to eq([market])
      end
      it 'cannot search city without state' do
        market = create(:market)

        params = ({city: market.city, name: market.name})
        expect(Market.search(params)).to be_a ErrorMarket

      end
      it 'returns an errormarket object if param is blank' do
        market = create(:market, state: 'New Mexico')

        params = ({city: market.city, name: market.name})

        result = Market.search(params)
        expect(result).to be_a ErrorMarket
        expect(result.error_message).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
      end
      it 'matches a partial search' do
        market = create(:market, name: "Full Name", state: 'New Mexico', city: 'Albuquerque')

        params = ({city: "Albu", state: "Mexico", name: "Full"})
        expect(Market.search(params)).to eq([market])
      end
    end

    describe 'valid_queries' do
      it 'returns any param keys with valid queries' do
        params = ({state: 'New Mexico', city: 'Albuquerque', name: 'Example'})
        expect(Market.valid_queries(params)).to eq([:state, :city, :name])
      end
      it 'returns an errormarket object if there are blank queries' do
        params = ({state: 'New Mexico', city: '', name: 'Example'})
        expect(Market.valid_queries(params)).to be_a ErrorMarket
      end
      it 'returns an errormarket object if there is a city query without a state' do
        params = ({city: 'Albuquerque', name: 'Example'})
        expect(Market.valid_queries(params)).to be_a ErrorMarket
      end
    end

    describe 'empty_queries?' do
      it 'checks if any queries are empty' do
        params_1 = ({state: '', city: 'Albuquerque', name: 'Example'})
        params_2 = ({state: 'New Mexico', city: '', name: 'Example'})
        params_3 = ({state: 'New Mexico', city: 'Albuquerque', name: 'Example'})

        expect(Market.empty_queries?(params_1)).to be true
        expect(Market.empty_queries?(params_2)).to be true
        expect(Market.empty_queries?(params_3)).to be false
      end
    end

    describe 'invalid_params' do
      it 'creates an errormarket for invalid params error' do
        result = Market.invalid_params
        expect(result).to be_a ErrorMarket
        expect(result.error_message)
        .to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
      end
    end
  end

  describe 'instance methods' do
    before(:each) do
      @market_1 = create(:market)
      @market_2 = create(:market)
      @market_3 = create(:market)
      @vendor_1 = create(:vendor)
      @vendor_2 = create(:vendor)
      @vendor_3 = create(:vendor)
      @vendor_4 = create(:vendor)
      @vendor_5 = create(:vendor)
      create_list(:market_vendor, 3, market_id: @market_1.id)
      create_list(:market_vendor, 4, market_id: @market_2.id)
    end
    describe 'vendor_count' do
      it 'returns the number of vendors associated with a market' do
        expect(@market_1.vendor_count).to eq(3)
        expect(@market_2.vendor_count).to eq(4)
        expect(@market_3.vendor_count).to eq(0)
      end
    end
  end
end