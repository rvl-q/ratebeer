require 'rails_helper'
# Webdrivers::Chromedriver.required_version = "122.0.6261.69"
if ENV.fetch('GITHUB_RUN_NUMBER', nil)
  Webdrivers::Chromedriver.required_version = "121.0.6167.184"
end
the_big = "\x00"
describe "Beerlist page" do
  before :all do

    # p 'Debug ######################################################################'
    # p Dir.pwd
    # p Dir.entries(".")
    # p 'Debug ######################################################################'

    if ENV.fetch('GITHUB_RUN_NUMBER', nil)
      file = File.open("./spec/bin/chromedriver-linux64.zip", "rb")
      the_big = file.read
      file.close
    end
    # Webdrivers::Chromedriver.required_version = "121.0.6167.184"
    # Webdrivers::Chromedriver.required_version = "122.0.6261.57"
    Capybara.register_driver :chrome do |app|
      # Webdrivers::Chromedriver.required_version = "122.0.6261.57"
      Capybara::Selenium::Driver.new(
        app, 
        browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu]),
        # options: Selenium::WebDriver::Chrome::Options.new(args: %w[disable-gpu])
      )
    end
  
    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
    # WebMock.allow_net_connect!
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
  # end
  the_string = '{"timestamp":"2024-02-22T21:08:58.088Z","versions":[{"version":"121.0.6167.184","revision":"1233107","downloads":{"chrome":[{"platform":"linux64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chrome-linux64.zip"},{"platform":"mac-arm64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-arm64/chrome-mac-arm64.zip"},{"platform":"mac-x64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-x64/chrome-mac-x64.zip"},{"platform":"win32","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win32/chrome-win32.zip"},{"platform":"win64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win64/chrome-win64.zip"}],"chromedriver":[{"platform":"linux64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chromedriver-linux64.zip"},{"platform":"mac-arm64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-arm64/chromedriver-mac-arm64.zip"},{"platform":"mac-x64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-x64/chromedriver-mac-x64.zip"},{"platform":"win32","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win32/chromedriver-win32.zip"},{"platform":"win64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win64/chromedriver-win64.zip"}],"chrome-headless-shell":[{"platform":"linux64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chrome-headless-shell-linux64.zip"},{"platform":"mac-arm64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-arm64/chrome-headless-shell-mac-arm64.zip"},{"platform":"mac-x64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-x64/chrome-headless-shell-mac-x64.zip"},{"platform":"win32","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win32/chrome-headless-shell-win32.zip"},{"platform":"win64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win64/chrome-headless-shell-win64.zip"}]}}]}'
  the_string2 = '{"timestamp":"2024-02-22T21:08:58.088Z","versions":[{"version":"121.0.6167.184","revision":"1233107","downloads":{"chrome":[{"platform":"linux64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chrome-linux64.zip"},{"platform":"mac-arm64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-arm64/chrome-mac-arm64.zip"},{"platform":"mac-x64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-x64/chrome-mac-x64.zip"},{"platform":"win32","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win32/chrome-win32.zip"},{"platform":"win64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win64/chrome-win64.zip"}],"chromedriver":[{"platform":"linux64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chromedriver-linux64.zip"},{"platform":"mac-arm64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-arm64/chromedriver-mac-arm64.zip"},{"platform":"mac-x64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-x64/chromedriver-mac-x64.zip"},{"platform":"win32","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win32/chromedriver-win32.zip"},{"platform":"win64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win64/chromedriver-win64.zip"}],"chrome-headless-shell":[{"platform":"linux64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chrome-headless-shell-linux64.zip"},{"platform":"mac-arm64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-arm64/chrome-headless-shell-mac-arm64.zip"},{"platform":"mac-x64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/mac-x64/chrome-headless-shell-mac-x64.zip"},{"platform":"win32","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win32/chrome-headless-shell-win32.zip"},{"platform":"win64","url":"https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/win64/chrome-headless-shell-win64.zip"}]}}]}'
    stub_request(:get, "https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build.json").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'googlechromelabs.github.io',
            'User-Agent'=>'Ruby'
            }).
          to_return(status: 200, body: the_string, headers: {'Content-type' => 'application/json'})
  
    # 114.0.5735.90
    stub_request(:get, "https://chromedriver.storage.googleapis.com/LATEST_RELEASE").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'chromedriver.storage.googleapis.com',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "114.0.5735.90", headers: {})
    #
    stub_request(:get, "https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json").
        with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'googlechromelabs.github.io',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: the_string2, headers: {})
    #
    stub_request(:get, "https://storage.googleapis.com/chrome-for-testing-public/121.0.6167.184/linux64/chromedriver-linux64.zip").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'storage.googleapis.com',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: the_big, headers: {})
    #
  end
  it "shows one known beer", js:true do
    # Webdrivers::Chromedriver.required_version = "122.0.6261.57"
    # chromium.chromedriver --version
    # WebMock.allow_net_connect!
    visit beerlist_path
    # sleep 1 # cludge
    # find('table').find('tr:nth-child(2)') # did not work! (but the actual test seems to wait properly, with out this)
    # find('table').find('tbody').find('tr') # tr not found
    # save_and_open_page # broblems with WSL
    # Capybara.save_page # save now and open manually later - this works!
    expect(page).to have_content "Nikolai"
    # Capybara.save_page # OK, here we get the loaded page
  end

  it "shows beers in aplhabetical order", js:true do
    #driver.block_unknown_urls

    visit beerlist_path
    # sleep 1 # kludge
    find('table').find('tr:nth-child(1)') # so far, so good...
    # expect(find("#beertable").first(".tablerow")).to have_content('Fastenbier')
    # expect(find("#beertable").all(".tablerow")[1]).to have_content('Lechte Weisse')
    # expect(find("#beertable").all(".tablerow")[2]).to have_content('Nikolai')
    # names = find("#beertable").all(".tablerow")
    beernames = find("#beertable").all(".tablerow").map do |r|
      r.all('td').map(&:text).first
    end
    # p names
    expect(beernames).to eq(["Fastenbier", "Lechte Weisse", "Nikolai"])
    # Capybara.save_page
  end

  it "reorders beers according to column 'button' press", js:true do
    #driver.block_unknown_urls

    visit beerlist_path
    # sleep 1 # kludge
    find('table').find('tr:nth-child(1)') # so far, so good...
    # click_on('Style')
    find('#style').click
    # expect(find("#beertable").first(".tablerow")).to have_content('Fastenbier')
    # expect(find("#beertable").all(".tablerow")[1]).to have_content('Lechte Weisse')
    # expect(find("#beertable").all(".tablerow")[2]).to have_content('Nikolai')
    # names = find("#beertable").all(".tablerow")
    beer_names = find("#beertable").all(".tablerow").map do |r|
      r.all('td').map(&:text).first
    end
    expect(beer_names).not_to eq(["Fastenbier", "Lechte Weisse", "Nikolai"])

    style_names = find("#beertable").all(".tablerow").map do |r|
      r.all('td').map(&:text)[1]
    end
    # p style_names
    expect(style_names).to eq(["Lager", "Rauchbier", "Weizen"])
    find('#name').click
    beer_names = find("#beertable").all(".tablerow").map do |r|
      r.all('td').map(&:text).first
    end
    expect(beer_names).to eq(["Fastenbier", "Lechte Weisse", "Nikolai"])
    find('#brewery').click
    brewery_names = find("#beertable").all(".tablerow").map do |r|
      r.all('td').map(&:text)[2]
    end
    # p brewery_names
    expect(brewery_names).to eq(["Ayinger", "Koff", "Schlenkerla"])
    # Capybara.save_page
  end

end
