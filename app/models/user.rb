class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username,  uniqueness: true,
                        length: { in: 3..30 }
  validates :password, length: { minimum: 4 },
                       format: { with: /\A[A-Z].*\d|\d.*[A-Z]\z/, message: "must include one upper case letter and number" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.chunk { |r| r.beer.style }.map{ |b| style_average(b) }.max_by{ |_| _[1] }[0]
  end

  # ch = ratings.chunk {|r| r.beer.style}
  def style_average(record)
    style = record[0]
    ratings = record[1]
    points = ratings.map(&:score).sum(0.0)
    [style, points / ratings.size]
  end
  # avs = ch.map{|b| style_average(b)}
  # avs.max_by{|_| _[1]}[0]
end
