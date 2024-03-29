class Brewery < ApplicationRecord
  extend TopRank

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { only_integer: true,
                                   greater_than: 1039,
                                   less_than_or_equal_to: ->(_) { Time.now.year } }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  # def self.top(nnn)
  #   Brewery.all.sort_by{ |b| -b.average_rating }.first(nnn)
  #   # sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -b.average_rating }.first(nnn)
  #   # Brewery.all.sort_by(&:average_rating).first(nnn)
  #   # palauta listalta parhaat n kappaletta
  #   # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
  # end

  include RatingAverage
end
