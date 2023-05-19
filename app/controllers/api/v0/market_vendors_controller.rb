class Api::V0::MarketVendorsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :render_no_record_response
  # rescue_from ActiveRecord::RecordNotUnique, with: :render_record_not_unique
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid


  def create
    # @mv = MarketVendor.create!(market_vendor_params)
    # @mv.save
    # render json: successful_creation_message, status: 201

    @mv = MarketVendor.new(market_vendor_params)
    if @mv.save
      render json: successful_creation_message, status: 201
    elsif @mv.exist?
      render json: ErrorMarketVendorSerializer.new(@mv).message, status: 422
    else
      render json: ErrorMarketVendorSerializer.new(@mv).message, status: 404
    end
  end

  def destroy
    # @mv = MarketVendor.find_mv(params[:market_vendor])
    # @mv.destroy

    @mv = MarketVendor.find_mv(params[:market_vendor])
    if @mv.class == MarketVendor
      @mv.destroy
    else
      render json: ErrorMarketVendorSerializer.new(@mv).failed_delete, status: 404
    end
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def successful_creation_message
    {message: "Successfully added vendor to market"}
  end

  # def render_record_invalid(error)
  #   render json: ErrorSerializer.error_message(error.message), status: :bad_request
  # end

  # def render_no_record_response(error)
  #   render json: ErrorSerializer.error_message(error.message), status: :not_found
  # end

  # def render_record_not_unique(error)
  #   render json: ErrorSerializer.error_message(error.message), status: :unprocessable_entity
  # end
end