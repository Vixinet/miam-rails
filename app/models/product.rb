class Product < ApplicationRecord
  before_save :set_order
  validates :label, presence: true
  validates :base_price, presence: true
  validates :product_group_id, presence: true

  belongs_to :product_group
  has_many :product_variations, :dependent => :destroy

  enum status: [:live, :offline]

  def set_order
    unless self.order
      @next = Product.where(product_group_id: self.product_group_id).maximum("order")
      self.order = @next ? @next + 1 : 1;
    end
  end
end
