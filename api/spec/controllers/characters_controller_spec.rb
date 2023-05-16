require "rails_helper"

RSpec.describe CharactersController, type: :request do
  describe "GET /total" do
    before do
      get "/characters/total"
    end

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it_behaves_like "a JSON object"

    it "returns a total as an integer" do
      expect(response.parsed_body["total"]).to be_zero

      user = User.create(email: "user@example.com", password: "password")
      character = Character.create(name: "Joenn", user:)
      get "/characters/total"

      expect(response.parsed_body["total"]).to eq character.id
    end
  end
end
