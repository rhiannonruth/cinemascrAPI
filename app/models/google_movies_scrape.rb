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
      Cinema.new(name:      extract_cinema_name(cinema),
                 address:   extract_cinema_info(cinema, 'address'),
                 telephone: extract_cinema_info(cinema, 'telephone'),
                 movies:    extract_movies_list(cinema))
    end
  end

  def extract_cinema_name(cinema)
    cinema.search('.desc').search('.name').text
  end

  def extract_cinema_info(cinema, section)
    info = cinema.search('.desc').search('.info').text
    return info.match(/.*(?= -)/).to_s if section == 'address'
    return info.match(/(?<=- ).*/).to_s if section == 'telephone'
  end

  def extract_movies_list(cinema)
    cinema.search('.showtimes').search('.movie').map do |movie|
      Movie.new(title:     extract_movie_name(movie),
                length:    extract_movie_info(movie, 'length'),
                rating:    extract_movie_info(movie, 'rating'),
                showtimes: extract_movie_showtimes(movie))
    end
  end

  def extract_movie_info(movie, detail)
    info = movie.search('.info').text
    return info.match(/\d*hr \d*min/).to_s if detail == 'length'
    return info.match(/(?<=(Rated )).{1,3}(?= -)/).to_s if detail == 'rating'
  end

  def extract_movie_name(movie)
    movie.search('.name').text
  end

  def extract_movie_showtimes(movie)
    movie.search('.times').text.gsub(' &nbsp', ' ').split(' ')
  end

end
