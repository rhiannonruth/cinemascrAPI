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
      @first_cinema = @response[:cinemas].first
    end

    it "returns hash" do
      expect(@response).to be_a Hash
    end

    it "cinemas key is an array of cinema objects" do
      expect(@response[:cinemas]).to all(be_a Cinema)
    end

    it "first cinema object has expected attributes" do
      expect(@first_cinema.name).to eq "ICA Cinema"
      expect(@first_cinema.movies).to eq ["Little Men", "El clan", "Julieta", "Things to Come", "De Palma"]
    end

    it "movies within cinemas are an array" do
      expect(@first_cinema.movies).to be_an Array
    end

  end

end
