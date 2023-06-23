require "rails_helper"

RSpec.describe CurrentUserController, type: :request do
  describe "GET /current_user" do
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

    context "when the token is valid" do
      before do
        get "/current_user", headers: { Authorization: "Bearer #{jwt_token}" }
      end

      it_behaves_like "a JSON endpoint"

      it "returns a message" do
        expect(response.parsed_body["message"]).to eq "Logged in sucessfully."
      end

      it "returns a http status code of 200" do
        expect(response).to have_http_status :ok
      end
    end

    context "when user is not logged in" do
      it "returns a http status of 302" do
        user.destroy
        get "/current_user", headers: { Authorization: "Bearer #{jwt_token}" }

        expect(response).to have_http_status :found
      end
    end
  end
end
