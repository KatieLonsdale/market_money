class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates_presence_of :market_id, :vendor_id
  validate :unique_market_vendor

  def self.find_mv(ids)
    MarketVendor.find_by(market_id: ids[:market_id], vendor_id: ids[:vendor_id])
  end

  def unique_market_vendor
    if exist?
      errors.add(:base, "Market vendor asociation between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists")
    end
  end

  def exist?
    MarketVendor.exists?(market_id: market_id, vendor_id: vendor_id)
  end
end