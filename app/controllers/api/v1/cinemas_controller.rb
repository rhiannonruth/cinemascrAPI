class Api::V1::CinemasController < ApplicationController

  def show
    render nothing:true
  end

  def search
    postcode = params[:postcode]
    scraper = GoogleMoviesScrape.new
    render json: scraper.search_cinemas(postcode)
  end

end
