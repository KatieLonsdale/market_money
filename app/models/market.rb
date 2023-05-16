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

  def vendor_count
    vendors.count
  end
end