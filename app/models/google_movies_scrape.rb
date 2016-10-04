class GoogleMoviesScrape

  attr_reader :agent

  def initialize
    @agent = Mechanize.new
  end

  def search_cinemas(location)
    page = agent.get("http://www.google.com/movies?near=#{location}")
    { cinemas: get_cinema_info(page) }
  end

  private

  def get_cinema_info(page)
    page.search('.movie_results').search('.theater').map do |cinema|
      Cinema.new(name:   extract_cinema_name(cinema),
                 movies: extract_movies_list(cinema))
    end
  end

  def extract_cinema_name(cinema)
    cinema.search('.desc').search('.name').text
  end

  def extract_movies_list(cinema)
    cinema.search('.showtimes').search('.movie').map do |movie|
      Movie.new(title:       extract_movie_name(movie),
                imdb_rating: extract_imdb_rating(movie),
                showtimes:   extract_movie_showtimes(movie))
    end
  end

  def extract_imdb_rating(movie)
    # finds imdb link then uses regex to match actual url
    imdb_link = movie.search('.//a[text()="IMDb"]/@href').text.match(/(?<=(q=)).*\//).to_s
    return "unavailable" if imdb_link == ""
    # creates mechanize page for the imdb page
    imdb_page = agent.get(imdb_link)
    # gets rating from page
    rating = imdb_page.search('//div[@class="ratingValue"]').text.match(/(...)(?=\/)/).to_s
    # rescue for empty string
    rating = "unavailable" if rating == ""
    rating
  end

  def extract_movie_name(movie)
    movie.search('.name').text
  end

  def extract_movie_showtimes(movie)
    movie.search('.times').text.gsub(' &nbsp', ' ').split(' ')
  end

end
