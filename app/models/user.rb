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
    return nil if ratings.empty? # palautetaan nil jos reittauksia ei ole

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.chunk { |r| r.beer.style }.map{ |b| favorite_average(b) }.max_by{ |s| s[1] }[0]
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.chunk { |r| r.beer.brewery }.map{ |b| favorite_average(b) }.max_by{ |s| s[1] }[0]
  end

  def favorite_average(record)
    first = record[0]
    ratings = record[1]
    points = ratings.map(&:score).sum(0.0)
    [first, points / ratings.size]
  end

  def self.most_active(nnn)
    User.all.sort_by{ |u| -u.ratings.count }.first(nnn)
  end

  def to_s
    username
  end
end
