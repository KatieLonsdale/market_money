require 'rails_helper'

RSpec.describe ErrorVendor do
  describe 'initialize' do
    it 'exists and has an error message' do
      error_vendor = ErrorVendor.new("error message")
      expect(error_vendor).to be_a ErrorVendor
      expect(error_vendor.error_message).to eq("error message")
    end
  end
end