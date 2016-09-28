require 'rails_helper'

RSpec.describe Api::V1::CinemasController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show, id: "sw156sj"
      expect(response).to have_http_status(:success)
    end
  end

  describe "search" do
    it "returns http success" do
      get :search
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json.include?('cinemas')).to eq true
    end
  end

end
