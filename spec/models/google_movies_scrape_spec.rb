require 'rails_helper'

RSpec.describe GoogleMoviesScrape, type: :model do

  let!(:scraper){ described_class.new }

  describe "#initialize" do
    it "creates a mechanize agent on init" do
      expect(scraper.agent).to_not be nil
    end
  end

  describe "#search_cinemas" do
    before do
      london_search_page = File.read("./spec/fixtures/GoogleMoviesLondonSearch.html")
      FakeWeb.register_uri(:get,
                           "https://www.google.com/movies?near=London",
                           body: london_search_page,
                           content_type: "text/html")
    end

    it "returns hash" do
      response = scraper.search_cinemas("London")
      expect(response).to be_a Hash
    end
  end

end
