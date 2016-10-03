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
      Movie.new(title:     extract_movie_name(movie),
                showtimes: extract_movie_showtimes(movie))
    end
  end

  def extract_movie_name(movie)
    movie.search('.name').text
  end

  def extract_movie_showtimes(movie)
    movie.search('.times').text.gsub(' &nbsp', ' ').split(' ')
  end

end
