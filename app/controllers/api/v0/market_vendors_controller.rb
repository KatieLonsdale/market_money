class Api::V0::MarketVendorsController < ApplicationController
  def create
    @mv = MarketVendor.new(market_vendor_params)
    if @mv.save
      render json: successful_creation_message
    else
      render json: ErrorMarketVendorSerializer.new(@mv).not_found, status: 404
    end
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def successful_creation_message
    {message: "Successfully added vendor to market"}
  end
end