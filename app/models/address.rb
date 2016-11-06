class Address < ApplicationRecord
  belongs_to :user

  after_validation :geocode, :if => Proc.new { |a| a.street? || a.city? }
  
  validates :street, presence: true
  validates :city, presence: true
  validates :user_id, presence: true

  enum status: [:online, :deleted]

  geocoded_by :address
  
  def address 
    [street, city, "CH"].compact.join(', ')
  end

  def falsify_all_others
	self.class.where('id != ? and default', self.id).update_all("default = 'false'")
  end
end
