class Venue < ApplicationRecord
  after_validation :geocode, :if => Proc.new { |a| a.street_changed? || a.city_name_changed? }

  validates :name, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  validates :street, presence: true
  validates :city_name, presence: true

  validates_inclusion_of :accepts_take_away, :in => [true, false]
  validates_inclusion_of :accepts_delivery, :in => [true, false]

  belongs_to :merchant
  belongs_to :city

  has_many :product_groups, :dependent => :destroy
  has_many :products, :through => :product_groups

  geocoded_by :address
  
  enum status: [:editing, :live, :offline]

  def live_product_groups
    product_groups.where(:status => :live).order(:order)
  end 

  def website_url_with_assumed_protocol
    url = self[:website]
    unless url.starts_with?("http") 
      url = "http://#{url}"
    end
    return url
  end

  def address 
    [street, city_name, "CH"].compact.join(', ')
  end
end
