class Style < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :beers, dependent: :destroy
end
