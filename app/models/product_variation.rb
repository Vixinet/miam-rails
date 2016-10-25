class ProductVariation < ApplicationRecord
  validates :label, presence: true
  validates :allow_multi_choices, presence: true
  validates :product_id, presence: true

  belongs_to :product
end
