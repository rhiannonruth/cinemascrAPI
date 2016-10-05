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

    context "cinema objects" do

      it "cinemas key is an array of cinema objects" do
        expect(@response[:cinemas]).to all(be_a Cinema)
      end

      it "cinema object has expected attributes" do
        expect(@first_cinema.name).to eq "ICA Cinema"
        expect(@first_cinema.address).to eq "The Mall, Institute of Contemporary Arts, London"
        expect(@first_cinema.telephone).to eq "020 7930 3647"
      end

    end

    context "movie objects" do

      it "movies key is an array of movie objects" do
        first_cinema_movies = @first_cinema.movies
        expect(first_cinema_movies).to all(be_a Movie)
      end

      it "movie object has expected title" do
        movies_titles = @first_cinema.movies.map { |m| m.title }
        expect(movies_titles).to eq ["Little Men", "El clan", "Julieta", "Things to Come", "De Palma"]
      end

      it "movie object has expected showtimes" do
        last_movie_showtimes = @first_cinema.movies.last.showtimes
        expect(last_movie_showtimes).to eq ["16:20", "18:30"]
      end

    end

  end

end
