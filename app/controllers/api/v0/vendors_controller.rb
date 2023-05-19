class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_record_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def index
    @market = Market.find(params[:market_id])
    render json: VendorSerializer.new(@market.vendors)
    # @market = Market.find_market(params[:market_id])
    # if @market.class == Market
    # else
    #   render json: ErrorMarketSerializer.new(@market).message, status: 404
    # end
  end

  def show
    @vendor = Vendor.find(params[:id])
    render json: VendorSerializer.new(@vendor)

    # @vendor = Vendor.find_vendor(params[:id])
    # if @vendor.class == Vendor
    #   render json: VendorSerializer.new(@vendor)
    # else
    #   render json: ErrorVendorSerializer.new(@vendor).not_found, status: 404
    # end
  end

  def create
    @vendor = Vendor.create!(vendor_params)
    @vendor.save
    render json: VendorSerializer.new(@vendor), status: 201
    
    # @vendor = Vendor.new_vendor(vendor_params)
    # if @vendor.class == Vendor
    #   @vendor.save
    #   render json: VendorSerializer.new(@vendor), status: 201
    # else
    #   render json: ErrorVendorSerializer.new(@vendor).create_failed, status: 400
    # end
  end

  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update!(vendor_params)
    render json: VendorSerializer.new(@vendor)

    # @vendor = Vendor.find_vendor(params[:id])
    # if @vendor.class == Vendor
    #   updated = @vendor.update_vendor(vendor_params)
    #   if updated.class == Vendor
    #     render json: VendorSerializer.new(updated)
    #   else
    #     render json: ErrorVendorSerializer.new(updated).create_failed, status: 400
    #   end
    # else
    #   render json: ErrorVendorSerializer.new(@vendor).not_found, status: 404
    # end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    # @vendor = Vendor.find_vendor(params[:id])
    # if @vendor.class == Vendor
    #   @vendor.destroy
    # else
    #   render json: ErrorVendorSerializer.new(@vendor).not_found, status: 404
    # end
  end

  def multiple_states
    @vendors = Vendor.multiple_states
    render json: VendorSerializer(@vendors)
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def render_no_record_response(error)
    render json: ErrorSerializer.error_message(error.message), status: :not_found
  end

  def render_record_invalid(error)
    render json: ErrorSerializer.error_message(error.message), status: :bad_request
  end
end