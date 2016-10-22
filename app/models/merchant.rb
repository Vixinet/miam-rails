class Merchant < ApplicationRecord
  validates :name, presence: true

  enum status: [:editing, :live, :offline]

  def delivery_cost
  	read_attribute(:delivery_cost).presence || 3.9
  end

  def free_delivery_limit
  	read_attribute(:free_delivery_limit).presence || 100
  end

  def small_order_surcharge
  	read_attribute(:small_order_surcharge).presence || 10
  end

  def maximum_distance
  	read_attribute(:maximum_distance).presence || 5
  end

  def long_delivery_surcharge
  	read_attribute(:long_delivery_surcharge).presence || 1.5
  end
end
