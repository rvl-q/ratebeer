require 'rails_helper'

include Helpers

describe "Beers page" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:user) { FactoryBot.create :user }
  let!(:style) { FactoryBot.create :style, name: 'Lager' }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "should have a link to the page for creating a new beer" do
    visit beers_path
    # save_and_open_page
    click_link('New Beer')
    expect(current_path).to eq(new_beer_path)
  end
    
  describe "creating a new beer" do
    before :each do
      visit (new_beer_path)
    end

    it "should succeed with proper parameters" do
      select('Lager', from: 'beer[style_id]')
      select('Koff', from: 'beer[brewery_id]')
      fill_in('beer[name]', with: 'Test23')
  
      expect{
        click_button "Create Beer"
      }.to change{Beer.count}.from(0).to(1)
    end  

    it "should not succeed without a name" do
      select('Lager', from: 'beer[style_id]')
      select('Koff', from: 'beer[brewery_id]')
  
      click_button "Create Beer"
  
      expect(Beer.count).to eq(0)  
    end  
  end
end