class PlacesController < ApplicationController
  def index
  end

  def show
    city = session["city"]&.downcase
    places = Rails.cache.read(city) if city
    place_id = places&.map(&:id)&.find_index(params[:id])
    @place = places[place_id] if places && place_id
    # binding.pry
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session["city"] = params[:city]
      render :index, status: 418
    end
  end
end
