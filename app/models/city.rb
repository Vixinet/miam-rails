class City < ApplicationRecord
  validates :label, presence: true
  enum status: [:live, :pending, :rejected]
end
