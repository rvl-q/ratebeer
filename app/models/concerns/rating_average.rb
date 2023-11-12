module RatingAverage
    extend ActiveSupport::Concern
   
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