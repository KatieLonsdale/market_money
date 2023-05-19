class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  # def self.find_market(id)
  #   market = Market.find_by(id: id)
  #   # if market
  #   #   market
  #   # else
  #   #   ErrorMarket.new("Couldn't find Market with 'id'=#{id}")
  #   # end
  # end

  def self.search(params)
    queries = valid_queries(params)
    return queries if queries.class == ErrorMarket
    results = Market.all
    queries.each do |query|
      search = query.to_s
      results = results.where("#{search} ILIKE ?", "%#{params[query]}%")
    end
    results
  end

  def self.valid_queries(params)
    if !params[:state].present? && params[:city].present?
      invalid_params
    elsif empty_queries?(params)
      invalid_params
    else
      params.keys
    end
  end

  def self.empty_queries?(params)
    params.values.any? {|value| value.empty?}
  end

  def self.invalid_params
    ErrorMarket.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
  end

  def vendor_count
    vendors.count
  end
end