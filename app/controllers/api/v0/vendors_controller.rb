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
    @vendor = Vendor.new_vendor(vendor_params)
    if @vendor.class == Vendor
      @vendor.save
      render json: VendorSerializer.new(@vendor), status: 201
    else
      render json: ErrorVendorSerializer.new(@vendor).create_failed, status: 400
    end
  end

  def update
    @vendor = Vendor.find_vendor(params[:id])
    if @vendor.class == Vendor
      updated = @vendor.update_vendor(vendor_params)
      if updated.class == Vendor
        render json: VendorSerializer.new(updated)
      else
        render json: ErrorVendorSerializer.new(updated).create_failed, status: 400
      end
    else
      render json: ErrorVendorSerializer.new(@vendor).not_found, status: 404
    end
  end

  def destroy
    @vendor = Vendor.find_vendor(params[:id])
    if @vendor.class == Vendor
      @vendor.destroy
    else
      render json: ErrorVendorSerializer.new(@vendor).not_found, status: 404
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end