class VariationOption < ApplicationRecord
  before_save :set_order
  
  validates :label, presence: true
  validates :price_variation, presence: true
  validates :product_variation_id, presence: true
  
  validates_inclusion_of :allow_multi_choices, :in => [true, false]
  validates_inclusion_of :default, :in => [true, false]

  belongs_to :product_variation

  def set_order
    unless self.order
      @next = VariationOption.where(product_variation_id: self.product_variation_id).maximum("order")
      self.order = @next ? @next + 1 : 1;
    end
  end
end
