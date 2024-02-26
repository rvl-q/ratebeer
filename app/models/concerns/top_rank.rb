# Common "top something" method for breweries, beers and styles
module TopRank
  def top(count)
    all.sort_by{ |b| -b.average_rating }.first(count)
  end
end
