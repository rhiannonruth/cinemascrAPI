class Api::V1::CinemasController < ApplicationController

  def show
    render nothing:true
  end

  def search
    response.headers['Access-Control-Allow-Origin'] = '*'
    postcode = params[:postcode]
    scraper = GoogleMoviesScrape.new
    render json: scraper.search_cinemas(postcode)
  end

end
