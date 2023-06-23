require "rails_helper"

def post_sign_in(email, password)
  post "/users/sign_in",
    params: { user: { email:, password: } }.to_json,
    headers: { "Content-Type": "application/json" },
    env: { "devise.mapping": Devise.mappings[:user] }
end

RSpec.describe Users::SessionsController, type: :request do
  let!(:user) { User.create(email: "user@example.com", password: "password") }

  describe "POST /users/sign_in" do
    context "when the user is authenticated" do
      before do
        post_sign_in(user.email, user.password)
      end

      it_behaves_like "a JSON endpoint"

      it "returns the authenticated user" do
        id = response.parsed_body["user"]["id"]
        expect(User).to exist(id:)
      end

      it "returns a message" do
        expect(response.parsed_body["message"]).to eq "Logged in sucessfully."
      end

      it "responds with a status code of 200" do
        expect(response).to have_http_status :ok
      end
    end

    context "when the user is not authenticated" do
      before do
        post_sign_in("Wrong Email", user.password)
        get "/users/sign_in", headers: { "Content-Type": "application/json" } if response.status == 302
      end

      it_behaves_like "a JSON endpoint"

      it "returns a message" do
        expect(response.parsed_body["message"]).to match "User couldn't be logged in successfully."
      end

      it "returns an array of errors" do
        expect(response.parsed_body["errors"]).to be_any
      end

      it "returns a http status code of 422" do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "DELETE /users/sign_out" do
    context "when the user is signed out successfully" do
      before do
        sign_in user
        delete "/users/sign_out", env: { "devise.mapping": Devise.mappings[:user] }
      end

      it_behaves_like "a JSON endpoint"

      it "responds with a success message" do
        expect(response.parsed_body["message"]).to eq "logged out successfully"
      end

      it "responds with a status code of 200" do
        expect(response).to have_http_status :ok
      end
    end

    context "when the user is not signed out successfully" do
      before do
        delete "/users/sign_out", env: { "devise.mapping": Devise.mappings[:user] }
      end

      it_behaves_like "a JSON endpoint"

      it "responds with a success message" do
        expect(response.parsed_body["message"]).to eq "Hmm nothing happened."
      end

      it "responds with a status code of 422" do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
