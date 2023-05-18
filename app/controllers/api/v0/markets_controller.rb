class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    @market = Market.find_market(params[:id])
    if @market.class == Market
      render json: MarketSerializer.new(@market)
    else
      render json: ErrorMarketSerializer.new(@market).message, status: 404
    end
  end

  def search
    @markets = Market.search(params)
    if @market.class != ErrorMarket
      render json: MarketSerializer.new(@markets)
    else
      render json: ErrorMarketSerializer.new(@market).message, status: 422
    end
  end
end