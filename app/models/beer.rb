class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        if self.ratings.empty?
            return nil
        end
        c = self.ratings.count.to_f
        ss = 0.0
        self.ratings.each do |rat|
            ss = ss + rat.score
        end
        ss / c
    end
end
