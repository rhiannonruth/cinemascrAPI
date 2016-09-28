require 'rails_helper'

RSpec.describe GoogleMoviesScrape, type: :model do

  let!(:scraper){ GoogleMoviesScrape.new }

  context "initialization" do
    it "creates a mechanize agent on init" do
      expect(scraper.agent).to_not be nil
    end
  end

  context "scraping" do
    it "returns an array" do
      response = scraper.search_cinemas("London")
      expect(response).to be_a Hash
    end
  end

end
