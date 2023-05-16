require "rails_helper"

def log_out
  delete "/users/sign_out", env: { "devise.mapping": Devise.mappings[:user] }
end

RSpec.describe "Users::Sessions", type: :request do
  let!(:user) { User.create(email: "user@example.com", password: "password") }

  describe "POST /create" do
    context "When user is logged in sucessfuly" do
      before do
        post_sign_in(user.email, user.password)
      end

      it_behaves_like "a JSON object"

      it "responds with the logged in user and a success message" do
        expect(response.parsed_body.key?("user")).to be_truthy
        expect(response.parsed_body["message"]).to eq "Logged in sucessfully."
      end

      it "responds with a status code of 200" do
        expect(response).to be_successful
      end
    end

    context "When user is not logged in successfuly" do
      before do
        post_sign_in("Wrong Email", user.password)
        get "/users/sign_in", headers: { "Content-Type": "application/json" } if response.status == 302
      end

      it_behaves_like "a JSON object"

      it "responds with an error message" do
        expect(response.parsed_body["errors"]).to include "Invalid Email or Password."
      end

      it "responds with a status code of 422" do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "DELETE /destroy" do
    context "When user is logged out successfully" do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        log_out
      end

      it_behaves_like "a JSON object"

      it "responds with a success message" do
        expect(response.parsed_body["message"]).to eq "logged out successfully"
      end

      it "responds with a status code of 200" do
        expect(response).to be_successful
      end
    end

    context "When user is not logged out successfully" do
      before do
        log_out
      end

      it_behaves_like "a JSON object"

      it "responds with a success message" do
        expect(response.parsed_body["message"]).to eq "Hmm nothing happened."
      end

      it "responds with a status code of 404" do
        expect(response).to have_http_status :not_found
      end
    end
  end
end
