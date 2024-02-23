require 'rails_helper'

describe "Beerlist page" do
  before :all do
    stub_request(:get, /.*googlechromelabs.*/).to_return(body: "", headers:{})
    
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
      options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
      # options: Selenium::WebDriver::Chrome::Options.new(args: %w[disable-gpu])
    end
  
    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  # stub_request(:get, "https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build.json").
  #        with(
  #          headers: {
  #      	  'Accept'=>'*/*',
  #      	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #      	  'Host'=>'googlechromelabs.github.io',
  #      	  'User-Agent'=>'Ruby'
  #          }).
  #        to_return(status: 200, body: "", headers: {})

  it "shows one known beer", js:true do    

    visit beerlist_path
    # sleep 1 # cludge
    # find('table').find('tr:nth-child(2)') # did not work! (but the actual test seems to wait properly, with out this)
    # find('table').find('tbody').find('tr') # tr not found
    # save_and_open_page # broblems with WSL
    # Capybara.save_page # save now and open manually later - this works!
    expect(page).to have_content "Nikolai"
    # Capybara.save_page # OK, here we get the loaded page
  end
end