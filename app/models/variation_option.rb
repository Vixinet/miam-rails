class VariationOption < ApplicationRecord
  validates :label, presence: true
  validates :price_variation, presence: true
  validates :product_variation_id, presence: true
  validates_inclusion_of :allow_multi_choices, :in => [true, false]

  belongs_to :product_variation
end
