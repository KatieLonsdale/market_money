class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates_presence_of :name, 
                        :description, 
                        :contact_name, 
                        :contact_phone
  validates :credit_accepted, inclusion: [true, false]
  validates :credit_accepted, exclusion: [nil]

  def self.find_vendor(id)
    vendor = Vendor.find_by(id: id)
    if vendor
      vendor
    else
      ErrorVendor.new("Couldn't find Vendor with 'id'=#{id}")
    end
  end
end