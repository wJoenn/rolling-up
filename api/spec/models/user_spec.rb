require "rails_helper"

def test_user_with_invalid_params(params)
  invalid_user = User.create(params)
  expect(invalid_user.persisted?).to be_falsy
end

RSpec.describe User, type: :model do
  let!(:email) { "user@example.com" }
  let!(:password) { "password" }
  let!(:user) { User.create(email:, password:) }

  describe "validations" do
    it "requires an email and a password" do
      expect(user.persisted?).to be_truthy

      test_user_with_invalid_params(email:)
      test_user_with_invalid_params(password:)
    end

    it "requires a valid email address" do
      test_user_with_invalid_params(email: "user@example", password:)
      test_user_with_invalid_params(email: "user@example.c", password:)
      test_user_with_invalid_params(email: "user.example.com", password:)
    end

    it "requires a unique email address" do
      test_user_with_invalid_params(email:, password:)
    end

    it "requires a valid password" do
      test_user_with_invalid_params(email:, password: "12345")
    end
  end
end
