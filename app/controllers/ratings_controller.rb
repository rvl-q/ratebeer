class RatingsController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :expire_brewerylist, only: [:destroy, :new, :create]

  def index
    # Old version
    # @ratings = Rating.includes(:beer, :user).all
    # @recent_ratings = Rating.includes(:user).recent # .includes(:user) no big diff, but this was a suboptimal approach as we already have @rating
    # @top_breweries = Brewery.top(3)
    # @top_beers = Beer.top(3)
    # @top_styles = Style.top(3)
    # @active_users = User.most_active(3)

    # New version. Nothing fancy here. With Sucker Punch refreshing (not yet implemented), this could respond OK.
    @ratings = Rails.cache.fetch('ratings', expires_in: 15.minutes) { Rating.includes(:beer, :user).all }
    @recent_ratings = Rails.cache.fetch('recent_ratings', expires_in: 1.minute) { Rating.recent }
    @top_breweries = Rails.cache.fetch('top_breweries', expires_in: 15.minute) { Brewery.top(3) }
    @top_beers = Rails.cache.fetch('top_beers', expires_in: 15.minute) { Beer.top(3) }
    @top_styles = Rails.cache.fetch('top_styles', expires_in: 15.minute) { Style.top(3) }
    @active_users = Rails.cache.fetch('active_users', expires_in: 15.minute) { User.most_active(3) }
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
