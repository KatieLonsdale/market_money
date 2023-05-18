require 'rails_helper'

RSpec.describe ErrorMarket do
  describe 'initialize' do
    it 'exists and has an error message' do
      error_market = ErrorMarket.new("error message")
      expect(error_market).to be_a ErrorMarket
      expect(error_market.error_message).to eq("error message")
    end
  end
end