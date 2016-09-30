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
                            "http://www.google.com/movies?near=London",
                            body: london_search_page,
                            content_type: "text/html")
      @response = scraper.search_cinemas("London")
    end

    it "returns hash" do
      expect(@response).to be_a Hash
    end

    it "cinemas key is an array of cinema objects" do
      expect(@response[:cinemas].all? {|x| x.class == Cinema }).to be true
    end

    it "movies within cinemas are an array" do
      first_cinema = @response[:cinemas].first
      expect(first_cinema.movies).to be_an Array
    end

  end

end
