require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "page should show the number of ratings" do
    FactoryBot.create :rating, score: '23', user:user, beer:beer1
    FactoryBot.create :rating, score: '24', user:user, beer:beer2
    FactoryBot.create :rating, score: '25', user:user, beer:beer1
    FactoryBot.create :rating, score: '26', user:user, beer:beer2
    visit ratings_path
    expect(Rating.count).to eq(4)
    expect(beer1.ratings.count).to eq(2)
    expect(beer2.ratings.count).to eq(2)
    expect(page).to have_content 'Number of ratings: 4'
  end

  it "user page should show own and only own ratings" do
    user2 = FactoryBot.create :user, username: 'Patka'
    FactoryBot.create :rating, score: '23', user:user, beer:beer1
    FactoryBot.create :rating, score: '24', user:user, beer:beer2
    FactoryBot.create :rating, score: '25', user:user, beer:beer1
    FactoryBot.create :rating, score: '26', user:user, beer:beer2
    FactoryBot.create :rating, score: '35', user:user2, beer:beer1
    FactoryBot.create :rating, score: '36', user:user2, beer:beer2
    visit user_path(user)
    expect(page).to have_content 'Has made 4 ratings'
  end

  it "deleting rating through user page should remove the rating from the db" do
    FactoryBot.create :rating, score: '35', user:user, beer:beer1
    FactoryBot.create :rating, score: '36', user:user, beer:beer2
    visit user_path(user)
    # Delete rating for beer2
    find(:xpath, "(//a[text()='Delete'])[2]").click
    expect(page).to have_content 'Has made 1 rating'
    expect(Rating.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer2.ratings.count).to eq(0)
  end
end