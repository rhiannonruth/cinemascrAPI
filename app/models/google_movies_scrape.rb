class GoogleMoviesScrape

  attr_reader :agent

  def initialize
    @agent = Mechanize.new
  end

  def search_cinemas(location)
    page = agent.get("http://www.google.com/movies?near=#{location}")
    { cinemas: get_cinema_names(page) }
  end

  private

  def get_cinema_names(page)
    page.search('.movie_results').search('.theater').search('.desc').search('.name').map do |name|
      name.text
    end
  end

end
