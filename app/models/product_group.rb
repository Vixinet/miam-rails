class ProductGroup < ApplicationRecord
  before_save :set_order
  validates :label, presence: true
  validates :status, presence: true
  validates :venue_id, presence: true
  belongs_to :venue
  has_many :products, :dependent => :destroy

  enum status: [:live, :offline]
	
  def set_order
    unless self.order
      @next = ProductGroup.where(venue_id: self.venue_id).maximum("order")
      self.order = @next ? @next + 1 : 1;
    end
  end
end
