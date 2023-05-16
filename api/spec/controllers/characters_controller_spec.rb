require "rails_helper"

RSpec.describe CharactersController, type: :request do
  describe "GET /total" do
    before do
      user = User.create(email: "user@example.com", password: "password")
      Character.create(name: "Joenn", user:)
      get "/characters/total"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns json response" do
      expect(response.body.class).to be(String)
      expect(response.parsed_body.class).to be(Hash)
    end

    it "returns a total as an integer" do
      expect(response.parsed_body["total"]).to be_an Integer
    end
  end
end
