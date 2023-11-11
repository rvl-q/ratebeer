class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        if self.ratings.empty?
            return nil
        end
        c = self.ratings.count.to_f
        self.ratings.map do |r|
          r.score
        end.sum / c
    end
end
