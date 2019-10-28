class Developer < ApplicationRecord
  has_many :develops

  validates :name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true
end
