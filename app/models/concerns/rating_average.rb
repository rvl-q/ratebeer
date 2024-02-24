# module RatingAverage
#   extend ActiveSupport::Concern

#   def average_rating
#     return 0 if ratings.empty?

#     # ratings.map(&:score).sum / ratings.count.to_f
#     ratings.average(:score).to_f
#   end
# end
module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    # tehdään laskelmat muistiin haettujen olueen liittyvien ratings-olioiden avulla
    rating_count = ratings.size
    
    return 0 if rating_count == 0
    ratings.map{ |r| r.score }.sum / rating_count
  end
end