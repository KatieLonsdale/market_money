class Api::V0::MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_no_record_response

  def index
    render json: MarketSerializer.new(Market.all)
  end
  
  def show
    @market = Market.find(params[:id])
    # if @market.class == Market
    render json: MarketSerializer.new(@market)
    # else
      # render json: ErrorMarketSerializer.new(@market).message, status: 404
    # end
  end
  
  def search
    @markets = Market.search(market_params)
    if @markets.class != ErrorMarket
      render json: MarketSerializer.new(@markets)
    else
      render json: ErrorMarketSerializer.new(@markets).message, status: 422
    end
  end
  
  def nearest_atms
    @atms = AtmFacade.new(params[:id]).closest_atms
    render json: AtmSerializer.new(@atms)
  end
  
  private
  def market_params
    params.permit(:name, :street, :city, :county, :state, :zip, :lat, :lon)
  end

  def render_no_record_response(error)
    render json: ErrorSerializer.error_message(error.message), status: :not_found
  end
end