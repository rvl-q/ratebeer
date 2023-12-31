require 'rails_helper' 

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a too short password" do
    user = User.create username: "Pekka", password: "Se1", password_confirmation: "Se1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with an invalid password" do
    user = User.create username: "Pekka", password: "secr", password_confirmation: "secr"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      style = FactoryBot.create(:style, name: 'Lager')
      beer = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, beer: beer, score: 10, user: user)
      FactoryBot.create(:rating, beer: beer, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "it corresponds to the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest _average_ rating if several rated" do
      fair = FactoryBot.create(:style, name: 'Fair')
      best = FactoryBot.create(:style, name: 'Best')
      secondbest = FactoryBot.create(:style, name: 'Secondbest')
      crappy = FactoryBot.create(:style, name: 'Crappy')
      create_beers_with_many_ratings({user: user, style: fair}, 10, 20, 15, 7, 9)
      create_beers_with_many_ratings({ user: user, style: best }, 50, 49, 48, 48, 47)
      create_beers_with_many_ratings({ user: user, style: secondbest }, 50, 49, 48, 46, 47)
      create_beers_with_many_ratings({user: user, style: crappy }, 1, 2, 5, 4, 3)

      expect(user.favorite_style).to eq(best)
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have a favorite brewey" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "it corresponds to the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the one with highest _average_ rating if several rated" do
      create_beers_with_many_ratings({user: user, brewery_name: "Fair"}, 10, 20, 15, 7, 9)
      create_beers_with_many_ratings({ user: user, brewery_name: "Best" }, 50, 49, 48, 48, 47)
      create_beers_with_many_ratings({ user: user, brewery_name: "Secondbest" }, 50, 49, 48, 46, 47)
      create_beers_with_many_ratings({user: user, brewery_name: "Crappy"}, 1, 2, 5, 4, 3)

      expect(user.favorite_brewery.name).to eq("Best")
    end
  end
end
