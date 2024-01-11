class Beer < ApplicationRecord
  include RatingAverage

  validates :name, presence: true
  # validates :style, presence: true

  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  def to_s
    "#{brewery.name}, #{name}"
  end

  def self.top(nnn)
    Beer.all.sort_by{ |b| -b.average_rating }.first(nnn)
  end
end
