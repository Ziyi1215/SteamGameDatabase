class Game < ApplicationRecord
  has_one :develop
  has_one :publish
  has_many :supports
  has_many :includes

  validates :name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0}

end
