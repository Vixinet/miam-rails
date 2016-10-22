class Merchant < ApplicationRecord
  before_save :set_default
  validates :name, presence: true
  enum status: [:editing, :live, :offline]
  
  private 

  def set_default
  	self.delivery_cost = 3.9 unless self.delivery_cost
  	self.free_delivery_limit = 100 unless self.free_delivery_limit
  	self.small_order_surcharge = 10 unless self.small_order_surcharge
  	self.maximum_distance = 5 unless self.maximum_distance
  	self.long_delivery_surcharge = 1.5 unless self.long_delivery_surcharge
  end
end
