class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :venue

  attr_accessor :products
end
