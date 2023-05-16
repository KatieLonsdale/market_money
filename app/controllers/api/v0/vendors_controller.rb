class Api::V0::VendorsController < ApplicationController
  def index
    @market = Market.find_market(params[:market_id])
    if @market.class == Market
      render json: VendorSerializer.new(@market.vendors)
    else
      render json: ErrorMarketSerializer.new(@market).not_found, status: 404
    end
  end

  def show
    @vendor = Vendor.find_vendor(params[:id])
    if @vendor.class == Vendor
      render json: VendorSerializer.new(@vendor)
    else
      render json: ErrorVendorSerializer.new(@vendor).not_found, status: 404
    end
  end
end