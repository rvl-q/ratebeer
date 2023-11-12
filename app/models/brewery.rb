class Brewery < ApplicationRecord
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def average_rating
        if self.ratings.empty?
            return nil
        end
        c = self.ratings.count.to_f
        self.ratings.map do |r|
          r.score
        end.sum / c
    end

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
