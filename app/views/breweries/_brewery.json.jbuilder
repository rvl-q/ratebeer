json.extract! brewery, :id, :name, :year, :active
json.beers do
  json.count brewery.beers.count
end
json.url brewery_url(brewery, format: :json)
