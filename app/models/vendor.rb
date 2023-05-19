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

  # def update_vendor(params)
  #   if update(params)
  #     self
  #   else
  #     ErrorVendor.new(errors.full_messages)
  #   end
  # end
end