class Venue < ApplicationRecord
  mount_uploader :venue_picture, VenuePictureUploader
  mount_uploader :venue_thumbnail_picture, VenueThumbnailPictureUploader
  
  after_validation :geocode, :if => Proc.new { |a| a.street_changed? || a.city_name_changed? }
  
  before_validation :set_slug

  validates :name, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  validates :street, presence: true
  validates :city_name, presence: true
  validates :slug, presence: true, :uniqueness => { :case_sensitive => false }

  validates_inclusion_of :accepts_take_away, :in => [true, false]
  validates_inclusion_of :accepts_delivery, :in => [true, false]

  belongs_to :merchant
  belongs_to :city

  has_many :product_groups, :dependent => :destroy
  has_many :products, :through => :product_groups

  geocoded_by :address
  
  enum status: [:editing, :live, :offline]

  def set_slug
    base_slug = name.to_slug
    slug = self.slug.blank? ? base_slug : self.slug
    i = 1
    if self.slug.blank? || Venue.where(slug: slug).count >= 1
      loop do
        break if Venue.where(slug: slug).count == 0
        i += 1
        slug = "#{base_slug}-#{i}"
      end
      self.slug = slug.downcase
    end
  end

  def to_param
    slug
  end

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
