require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:test_brewery) { Brewery.new name: "test", year: 2000 }
  let(:test_style) { Style.new name: "test style" }

  it "is succesfully created with good parameters" do
    beer = Beer.create name: "testbeer", style: test_style, brewery: test_brewery
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not created without name given" do
    beer = Beer.create style: test_style, brewery: test_brewery
    expect(beer).to be_invalid
    expect(Beer.count).to eq(0)
  end

  it "is not created without a style" do
    beer = Beer.create name: "testbeer", brewery: test_brewery
    expect(beer).to be_invalid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a valid brewery" do
    beer = Beer.new name: "testbeer", style: test_style, brewery: nil
    beer.brewery_id = 666 # => errors: Brewery must exist
    beer.save
    expect(beer).to be_invalid
    expect(Beer.count).to eq(0)
  end
end
