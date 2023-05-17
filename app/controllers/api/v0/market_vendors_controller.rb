class Api::V0::MarketVendorsController < ApplicationController
  def create
    MarketVendor.create(market_vendor_params)
    render json: successful_creation_message
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def successful_creation_message
    {message: "Successfully added vendor to market"}
  end
end