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
      cinema_name = extract_name(cinema)
      movies = extract_movies_list(cinema)
      Cinema.new(name: cinema_name, movies:  movies)
    end
  end

  def extract_name(cinema)
    cinema.search('.desc').search('.name').text
  end

  def extract_movies_list(cinema)
    cinema.search('.showtimes').search('.movie').map do |movie|
      name = movie.search('.name')
      showtimes = movie.search('.times').text.gsub(' &nbsp',' ').split(' ')
      Movie.new(name: name.text, showtimes:[showtimes])
    end
  end
end
