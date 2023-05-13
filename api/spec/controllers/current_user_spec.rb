require "rails_helper"

RSpec.describe CurrentUserController, type: :request do
  describe "GET /show" do
    let(:user) { User.create!(email: "user@example.com", password: "password") }
    let(:jwt_token) do
      token = {
        sub: user.id,
        scp: "user",
        aud: nil,
        iat: Time.current.to_i,
        exp: 1.month.from_now.to_i,
        jti: user.jti
      }

      JWT.encode(token, Rails.application.credentials.devise_jwt_secret_key!)
    end

    context "When the token is valid" do
      it "returns a success response" do
        get "/current_user", headers: { Authorization: "Bearer #{jwt_token}" }

        expect(response).to be_successful
        expect(response.parsed_body["message"]).to eq("Logged in sucessfully.")
      end
    end

    context "When user is not logged in" do
      it "returns an error response" do
        user.destroy
        get "/current_user", headers: { Authorization: "Bearer #{jwt_token}" }

        expect(response).to have_http_status(:found)
      end
    end
  end
end
