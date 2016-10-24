class ProductGroup < ApplicationRecord
  validates :label, presence: true
  validates :status, presence: true
  validates :venue_id, presence: true

  belongs_to :venue
  has_many :products, :dependent => :destroy

  enum status: [:live, :offline]
end
