class Vendor < ApplicationRecord
  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors

  validates_presence_of :name, 
                        :description, 
                        :contact_name, 
                        :contact_phone
  validates :credit_accepted, exclusion: [nil]

  # def self.find_vendor(id)
  #   vendor = Vendor.find_by(id: id)
  #   if vendor
  #     vendor
  #   else
  #     ErrorVendor.new("Couldn't find Vendor with 'id'=#{id}")
  #   end
  # end
  
  # def self.new_vendor(params)
  #   vendor = Vendor.new(params)
  #   if vendor.save
  #     vendor
  #   else
  #     ErrorVendor.new(vendor.errors.full_messages)
  #   end
  # end

  # def self.multiple_states
  #   Vendor.from(Vendor.joins(:markets).select('vendors.*, count(markets.state) AS states').group('vendors.id').order('count(markets.state) DESC').distinct).where('states > 1')
  # end

  def self.popular_states
    Vendor.joins(:market_vendors, :markets)
          .select('markets.state, count(market_vendors.id)')
          .order('count(market_vendors.id) DESC')
          .group('markets.state')
          .count('market_vendors.id')
  end

  def self.sells_in(state)
    Vendor.joins(:market_vendors, :markets)
          .where('markets.state ILIKE ?', "%#{state}%")
          .select('vendors.*, count(market_vendors.id)')
          .group('vendors.id')
          .order('count(market_vendors.id) DESC')
  end

  def states_sold_in
    markets.select(:state).distinct.order(:state).pluck(:state)
  end

  # def update_vendor(params)
  #   if update(params)
  #     self
  #   else
  #     ErrorVendor.new(errors.full_messages)
  #   end
  # end
end