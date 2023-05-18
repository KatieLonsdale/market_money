require 'rails_helper'

RSpec.describe ErrorMarketVendor do
  describe 'initialize' do
    it 'exists and has an error message' do
      error_market = ErrorMarketVendor.new("error message")
      expect(error_market).to be_a ErrorMarketVendor
      expect(error_market.error_message).to eq("error message")
    end
  end
end