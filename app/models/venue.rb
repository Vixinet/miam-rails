class Venue < ApplicationRecord
  validates :name, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  belongs_to :merchant
  has_many :product_groups, :dependent => :destroy
  has_many :products, :through => :product_groups

  enum status: [:editing, :live, :offline]

  def website_url_with_assumed_protocol
    url = self[:website]
    unless url.starts_with?("http") 
      url = "http://#{url}"
    end
    return url
  end
end
