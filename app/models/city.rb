class City < ApplicationRecord
  before_save :set_status
  validates :label, presence: true, :uniqueness => { :case_sensitive => false }
  has_many :venues
  enum status: [:live, :pending, :rejected]

  def set_status
    unless self.status
      self.status = :pending
    end
  end
end
