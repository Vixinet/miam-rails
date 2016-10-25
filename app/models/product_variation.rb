class ProductVariation < ApplicationRecord
  validates :label, presence: true
  validates :product_id, presence: true
  validates_inclusion_of :allow_multi_choices, :in => [true, false]

  belongs_to :product
  has_many :variation_options, :dependent => :destroy
end
