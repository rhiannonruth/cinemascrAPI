require 'rails_helper'

RSpec.describe GoogleMoviesScrape, type: :model do

  let!(:scraper){ described_class.new }

  describe "#initialize" do
    it "creates a mechanize agent on init" do
      expect(scraper.agent).to_not be nil
    end
  end

  describe "#search_cinemas" do
    it "returns hash" do
      response = scraper.search_cinemas("London")
      expect(response).to be_a Hash
    end
  end

end
