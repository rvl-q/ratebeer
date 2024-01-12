class Style < ApplicationRecord
  include RatingAverage
  validates :name, presence: true, uniqueness: true

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(nnn)
    Style.all.sort_by{ |b| -b.average_rating }.first(nnn)
  end
end
