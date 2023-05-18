class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def self.find_market(id)
    market = Market.find_by(id: id)
    if market
      market
    else
      ErrorMarket.new("Couldn't find Market with 'id'=#{id}")
    end
  end

  def self.search(params)
    if params[:state].present? && !params[:state].empty?
      results = Market.where('lower(state)=lower(?)', params[:state])
      if params[:city].present? && !params[:state].empty?
        results = results.where('lower(city)=lower(?)', params[:city])
          if params[:name].present? && !params[:city].empty?
            results = results.where('lower(name)=lower(?)', params[:name])
          end
      end
    elsif !params[:state].present? && !params[:city].present?
      if params[:name].present? && !params[:name].empty?
        results = Market.where('lower(name)=lower(?)', params[:name])
      end
    else
      results = ErrorMarket.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
    end
    results
  end

  def vendor_count
    vendors.count
  end
end