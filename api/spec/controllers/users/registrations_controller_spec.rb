require "rails_helper"

def create_user(params)
  post "/users",
    params: { user: params }.to_json,
    headers: { "Content-Type": "application/json" },
    env: { "devise.mapping": Devise.mappings[:user] }
end

RSpec.describe Users::RegistrationsController, type: :request do
  describe "POST /users" do
    let!(:correct_user_params) { { email: "user@example.com", password: "password" } }
    let!(:wrong_user_params) { { email: "user@example", password: "password" } }

    context "when the user is registered successfuly" do
      before do
        create_user(correct_user_params)
      end

      it_behaves_like "a JSON endpoint"

      it "creates a new user" do
        expect(User).to exist(email: "user@example.com")
      end

      it "returns the registered user" do
        id = response.parsed_body["user"]["id"]
        expect(User).to exist(id:)
      end

      it "returns a message" do
        expect(response.parsed_body["message"]).to eq "Signed up successfully."
      end

      it "returns a http status code of 200" do
        expect(response).to have_http_status :ok
      end
    end

    context "when the user is not registered successfully" do
      before do
        create_user(wrong_user_params)
      end

      it_behaves_like "a JSON endpoint"

      it "does not create a new user" do
        expect(User).not_to exist(email: "user@example.com")
      end

      it "returns a message" do
        expect(response.parsed_body["message"]).to match "User couldn't be created successfully."
      end

      it "returns an array of errors" do
        expect(response.parsed_body["errors"]).to be_any
      end

      it "returns a http status code of 422" do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "DELETE /users" do
    let(:user) { User.create(email: "user@example.com", password: "password") }

    before do
      sign_in user
      delete "/users"
    end

    it_behaves_like "a JSON endpoint"

    it "deletes the current user" do
      expect(User).not_to exist(id: user.id)
    end

    it "returns a message" do
      expect(response.parsed_body["message"]).to match "Account deleted successfully."
    end

    it "returns a http status code of 200" do
      expect(response).to have_http_status :ok
    end
  end
end
