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
        first_two_cinemas = @response[:cinemas].map { |c| [c.name, c.address, c.telephone] }.first(2)
        cinema_one = ["ICA Cinema", "The Mall, Institute of Contemporary Arts, London", "020 7930 3647"]
        cinema_two = ["Everyman Canary Wharf", "Canary Wharf, Crossrail Place - Level Minus Two, London, United Kingdom", "0871 906 9060"]
        expect(first_two_cinemas).to eq [cinema_one, cinema_two]
      end

    end

    context "movie objects" do

      it "movies key is an array of movie objects" do
        first_cinema_movies = @first_cinema.movies
        expect(first_cinema_movies).to all(be_a Movie)
      end

      it "movie objects have expected attributes" do
        movies = @first_cinema.movies.map { |m| [m.title, m.length, m.rating] }
        expect(movies).to eq [["Little Men", "1hr 25min", "UC"],
                              ["El clan", "1hr 48min", "UC"],
                              ["Julieta", "1hr 39min", "15"],
                              ["Things to Come", "1hr 40min", "12A"],
                              ["De Palma", "1hr 50min", "15"]]
      end

      it "movie object has expected showtimes" do
        last_movie_showtimes = @first_cinema.movies.last.showtimes
        expect(last_movie_showtimes).to eq ["16:20", "18:30"]
      end

    end

  end

end
