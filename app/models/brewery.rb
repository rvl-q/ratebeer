class Brewery < ApplicationRecord
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1040 }
  validate :year_cannot_be_in_the_future

  def year_cannot_be_in_the_future
    t = Time.now.year
    return unless year.present? && year > t

    errors.add(:year, "cannot be in the future (>#{t})")
  end

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end
