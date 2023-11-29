require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1, city: "Kumpula" ) ]
    )
    allow(WeatherApi).to receive(:weather_in).with("Kumpula").and_return(
      Weather.new( temperature: -1, wind_speed: 20, wind_dir: "S", location: "Kumpula", weather_icons: [] )
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if none is returned by the API, 'No locations in <city>' is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("espoo").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'espoo')
    click_button "Search"
    # save_and_open_page
    expect(page).to have_content "No locations in espoo"
  end

  it "if many returned by the API, all are shown on the page" do
    places = [Place.new( name: "Bar1", id: 1, city: "Helsinki" ),
              Place.new( name: "Bar2", id: 2 ),
              Place.new( name: rand_bar_name, id: 3 )]

    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      places
    )
    allow(WeatherApi).to receive(:weather_in).with("Helsinki").and_return(
      Weather.new( temperature: -1, wind_speed: 20, wind_dir: "S", location: "Helsinki", weather_icons: [] )
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"
    # save_and_open_page
    places.each do |p|
      expect(page).to have_content p.name
    end

  end
end

def rand_bar_name
  "Bar" + (Time.now.to_f*1000000).to_i.to_s
end