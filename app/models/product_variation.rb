class ProductVariation < ApplicationRecord
  before_save :set_order

  validates :label, presence: true
  validates :product_id, presence: true
  validates_inclusion_of :allow_multi_choices, :in => [true, false]

  belongs_to :product
  
  has_many :variation_options, :dependent => :destroy

  def default_choice
    variation_options.where(:default => true).first
  end

  def set_order
    unless self.order
      @next = ProductVariation.where(product_id: self.product_id).maximum("order")
      self.order = @next ? @next + 1 : 1;
    end
  end
end
