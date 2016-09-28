class GoogleMoviesScrape

  attr_reader :agent

  def initialize
    @agent = Mechanize.new
  end

  def search_cinemas(location)
    page = agent.get("https://www.google.co.uk/movies?near=#{location}")
    { cinemas: get_cinema_names(page) }
  end

  private

  def get_cinema_names(page)
    page.search('.movie_results').search('.theater').search('.desc').search('.name').map do |a|
      a.text
    end
  end

end
