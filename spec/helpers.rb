module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_beer_with_rating(object, score)
    style = object[:style]

    # if style then
    #   beer_style = ( Style.find_by(name: style) )? FactoryBot.create(:style, name: style) : Style.find_by(name: style)
    # end
    lager = Style.find_by(name: 'Lager') ? Style.find_by(name: 'Lager') : FactoryBot.create(:style, name: 'Lager')
    brewery_name = object[:brewery_name]
    beer = style ? FactoryBot.create(:beer, style: style ) : brewery_name ? create_beer_with_brewery(brewery_name) : FactoryBot.create(:beer, style: lager)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end
  
  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
    end
  end
  
  def create_beer_with_brewery(name)
    lager = Style.find_by(name: 'Lager') ? Style.find_by(name: 'Lager') : FactoryBot.create(:style, name: 'Lager')
    brewery = FactoryBot.create(:brewery, name: name)
    FactoryBot.create(:beer, style: lager, brewery: brewery)
  end  
end
