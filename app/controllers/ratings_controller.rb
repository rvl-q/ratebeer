class RatingsController < ApplicationController
    def index
        @ratings = Rating.all
    end

    def new
        @rating = Rating.new
        @beers = Beer.all
    end

    # def create
    #     raise
    # end
    def create
        Rating.create params.require(:rating).permit(:score, :beer_id)
        redirect_to ratings_path
        # redirect_to "http://www.cs.helsinki.fi"
    end
end