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

  def create
    @vendor = Vendor.create(vendor_params)
    render json: VendorSerializer.new(@vendor)
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

end