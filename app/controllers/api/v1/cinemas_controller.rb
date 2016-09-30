class Api::V1::CinemasController < ApplicationController

  def show
    render nothing:true
  end

  def search
    render json:{cinemas:[]}
  end

end
