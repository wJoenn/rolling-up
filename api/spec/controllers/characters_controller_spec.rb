require "rails_helper"

RSpec.describe CharactersController, type: :request do
  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:params) { { name: "Joenn" } }

  before do
    sign_in user
  end

  describe "GET /characters" do
    before do
      Character.create(name: "Joenn", user:)
      get "/characters"
    end

    it_behaves_like "it requires a user to be authenticated" do
      let(:action) { get "/characters" }
    end

    it_behaves_like "a JSON endpoint"

    it "returns http success" do
      expect(response).to have_http_status :success
    end

    it "returns a list of Character" do
      list = response.parsed_body["characters"]

      expect(list.pluck("name")).to all eq "Joenn"
    end
  end

  describe "POST /characters" do
    before do
      post "/characters", params: { character: params }
    end

    it_behaves_like "it requires a user to be authenticated" do
      let(:action) { post "/characters", params: { character: params } }
    end

    it_behaves_like "a JSON endpoint"

    context "when the params are correct" do
      it "creates and returns a new character" do
        id = response.parsed_body["character"]["id"]
        expect(Character).to exist(id:)
      end

      it "returns a message" do
        expect(response.parsed_body["message"]).to eq "Character created successfully."
      end

      it "returns http status code of 200" do
        expect(response).to have_http_status :ok
      end
    end

    context "when the params are incorrect" do
      before do
        sign_in user
        post "/characters", params: { character: { name: nil } }
      end

      it "returns a message" do
        expect(response.parsed_body["message"]).to eq "Character couldn't be created successfully."
      end

      it "returns an array of errors" do
        expect(response.parsed_body["errors"]).to be_any
      end

      it "returns a http status code of 402" do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "GET /characters/total" do
    let!(:character) { Character.create(name: "Joenn", user:) }

    before do
      get "/characters/total"
    end

    it_behaves_like "a JSON endpoint"

    it "returns the total number of characters created" do
      expect(response.parsed_body["total"]).to eq character.id
    end

    it "returns http status code of 200" do
      expect(response).to have_http_status :ok
    end
  end
end
