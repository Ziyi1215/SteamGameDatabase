class Publisher < ApplicationRecord
  has_many :publish

  validates :name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true
end
