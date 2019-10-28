class Language < ApplicationRecord
  has_many :support

  validates :name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true
end
