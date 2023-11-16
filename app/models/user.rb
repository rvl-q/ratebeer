class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username,  uniqueness: true,
                        length: { in: 3..30 }
  validates :password, length: { minimum: 4 }
  validate :validate_pwd

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def validate_pwd
    return unless (password.count("0-9") < 1) || (password.count("A-Z") < 1)

    errors.add(:password, "must contain at least one number and one Capital letter")
  end
end
