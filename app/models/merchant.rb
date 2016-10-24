class Merchant < ApplicationRecord
  validates :business_name, presence: true
  has_many :venues, :dependent => :destroy
end
