require 'rails_helper'

RSpec.describe AtmService do
  describe 'class methods' do
    describe 'nearby_atms' do
      it 'returns tomtom api results for atms' do
        response = AtmService.nearby_atms(30, -106)

        expect(response.dig(:summary, :geoBias)).to have_key(:lat)
        expect(response.dig(:summary, :geoBias, :lat)).to eq(30)
        expect(response.dig(:summary, :geoBias)).to have_key(:lon)
        expect(response.dig(:summary, :geoBias, :lon)).to eq(-106)

        expect(response.dig(:results, 0, :address)).to have_key(:freeformAddress)
        expect(response.dig(:results, 0, :position)).to have_key(:lat)
        expect(response.dig(:results, 0, :position)).to have_key(:lon)
        expect(response.dig(:results, 0)).to have_key(:dist)
      end
    end
  end
end