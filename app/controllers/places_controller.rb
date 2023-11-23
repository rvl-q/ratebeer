class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = "731955affc547174161dbd6f97b46538"
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"

    response = HTTParty.get "#{url}helsinki"
    places_from_api = response.parsed_response["bmp_locations"]["location"]
    @places = [ Place.new(places_from_api.first) ]

    render :index, status: 418
  end
end
