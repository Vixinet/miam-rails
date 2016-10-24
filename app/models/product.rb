class Product < ApplicationRecord
  validates :label, presence: true
  validates :base_price, presence: true
  validates :product_group_id, presence: true

  belongs_to :product_group
  #has_many :product_variations, :dependent => :destroy

  enum status: [:live, :offline]
end
