require 'rails_helper'

RSpec.describe Api::V1::CinemasController, type: :controller do

  let!(:cinema){ {"name"=>"ICA Cinema", "address"=>"The Mall, Institute of Contemporary Arts, London, United Kingdom", "telephone"=>"020 7930 3647", "movies"=>[{"title"=>"The Beatles: Eight Days a Week - The Touring Years", "length"=>"2hr 17min", "rating"=>"12A", "showtimes"=>["18:30"]}, {"title"=>"Little Men", "length"=>"1hr 25min", "rating"=>"PG", "showtimes"=>["14:00"]}, {"title"=>"Under the Shadow", "length"=>"1hr 24min", "rating"=>"15", "showtimes"=>["15:30", "20:55"]}, {"title"=>"De Palma", "length"=>"1hr 50min", "rating"=>"15", "showtimes"=>["16:00"]}]} }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: "sw156sj"
      expect(response).to have_http_status(:success)
    end
  end

  describe "search" do
    context 'search for London' do
      it "success with expected results" do
        get :search, location: 'London'
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['cinemas'].include?(cinema)).to eq true
      end
    end
  end

end
