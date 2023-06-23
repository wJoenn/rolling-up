require "rails_helper"

def test_user_with_invalid_params(params)
  invalid_user = User.create(params)
  expect(invalid_user).not_to be_persisted
end

RSpec.describe User do
  let!(:email) { "user@example.com" }
  let!(:password) { "password" }
  let!(:user) { described_class.create(email:, password:) }

  describe "validations" do
    it "requires an email and a password" do
      expect(user).to be_persisted

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

    it "assigns a unique JTI token when created" do
      described_class.create(email: "another@example.com", password:, jti: user.jti)
      unique_jtis = described_class.all.map(&:jti).uniq

      expect(unique_jtis.length).to eq 2
    end
  end

  describe "associations" do
    it "has many Character" do
      character = user.characters.create(name: "Joenn")
      expect(character).to be_persisted
    end
  end
end
