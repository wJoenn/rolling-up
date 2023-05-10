module Helpers
  module Authentication
    def post_sign_in(email, password)
      post "/login",
        params: { user: { email:, password: } }.to_json,
        headers: { "Content-Type": "application/json" },
        env: { "devise.mapping": Devise.mappings[:user] }
    end
  end
end
