class Beer < ApplicationRecord
  include RatingAverage
  extend TopRank

  validates :name, presence: true
  # validates :style, presence: true

  belongs_to :style # we need "backward touch" here
  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def to_s
    "#{brewery.name}, #{name}"
  end

  # def average
  #   return 0.0 if ratings.empty?

  #   ratings.map(:score).sum / ratings.count.to_f
  # end

  # def self.top(nnn)
  #   Beer.all.sort_by{ |b| -b.average_rating }.first(nnn)
  # end
end
