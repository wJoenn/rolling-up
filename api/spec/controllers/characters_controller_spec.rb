require "rails_helper"

RSpec.describe CharactersController, type: :request do
  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:params) { { name: "Joenn" } }

  describe "POST /create" do
    before do
      sign_in user
      post "/characters", params: { character: params }
    end

    it "requires to be logged in" do
      sign_out user
      post "/characters", params: { character: params }

      expect(response).to have_http_status :found
    end

    it_behaves_like "a JSON object"

    it "returns http success with proper params" do
      expect(response).to have_http_status :success
    end

    it "created a new Character with proper params" do
      expect(Character.exists?(name: "Joenn")).to be_truthy
    end

    it "creates a new Character with proper params" do
      expect(Character.exists?(name: "Joenn")).to be_truthy
      expect(response).to have_http_status :success
      expect(response.parsed_body["message"]).to eq "Character created successfully."
    end

    it "returns an error message with incorrect params" do
      sign_in user
      post "/characters", params: { character: { name: nil } }

      expect(response).to have_http_status :unprocessable_entity
      expect(response.parsed_body["message"]).to eq "Character couldn't be created successfully."
      expect(response.parsed_body["errors"].any?).to be_truthy
    end
  end

  describe "GET /index" do
    before do
      sign_in user
      Character.create(name: "Joenn", user:)
      get "/characters"
    end

    it "requires to be logged in" do
      sign_out user
      get "/characters"

      expect(response).to have_http_status :found
    end

    it_behaves_like "a JSON object"

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "returns a list of Character" do
      list = response.parsed_body["characters"]

      expect(list.length).to eq(1)
      expect(list.pluck("name")).to all eq "Joenn"
    end
  end

  describe "GET /total" do
    before do
      get "/characters/total"
    end

    it_behaves_like "a JSON object"

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "returns a total as an integer" do
      expect(response.parsed_body["total"]).to be_zero

      character = Character.create(name: "Joenn", user:)
      get "/characters/total"

      expect(response.parsed_body["total"]).to eq character.id
    end
  end
end
