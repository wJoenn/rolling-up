require "rails_helper"

def test_wrong_character(params)
  wrong_character = Character.create(params)
  expect(wrong_character).not_to be_persisted
end

RSpec.describe Character do
  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:name) { "Joenn" }
  let!(:character) { described_class.create(name:, user:) }

  describe "validations" do
    it "requires a name and a user" do
      expect(character).to be_persisted

      test_wrong_character(name:)
      test_wrong_character(user:)
    end

    it "requires a strength in a range of 0 to 20" do
      test_wrong_character(name:, user:, strength: -1)
      test_wrong_character(name:, user:, strength: 21)
    end

    it "requires a dexterity in a range of 0 to 20" do
      test_wrong_character(name:, user:, dexterity: -1)
      test_wrong_character(name:, user:, dexterity: 21)
    end

    it "requires a constitution in a range of 0 to 20" do
      test_wrong_character(name:, user:, constitution: -1)
      test_wrong_character(name:, user:, constitution: 21)
    end

    it "requires an intelligence in a range of 0 to 20" do
      test_wrong_character(name:, user:, intelligence: -1)
      test_wrong_character(name:, user:, intelligence: 21)
    end

    it "requires a wisdom in a range of 0 to 20" do
      test_wrong_character(name:, user:, wisdom: -1)
      test_wrong_character(name:, user:, wisdom: 21)
    end

    it "requires a charisma in a range of 0 to 20" do
      test_wrong_character(name:, user:, charisma: -1)
      test_wrong_character(name:, user:, charisma: 21)
    end

    it "has a default value of false for inspiration" do
      expect(character).not_to be_inspired
    end

    it "has a default value of 10 for its stats" do
      expect(character.base_stats.values).to all eq 10
    end
  end

  describe "associations" do
    it "belongs to a user" do
      expect(character.user).to be_a User
    end
  end

  describe "#ac" do
    it "return the base AC + the constition modifier" do
      character.update(constitution: 14)
      expect(character.ac).to eq 12
    end
  end

  describe "#strength_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.strength_modifier).to be_zero
    end
  end

  describe "#dexterity_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.dexterity_modifier).to be_zero
    end
  end

  describe "#constitution_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.constitution_modifier).to be_zero
    end
  end

  describe "#intelligence_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.intelligence_modifier).to be_zero
    end
  end

  describe "#wisdom_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.wisdom_modifier).to be_zero
    end
  end

  describe "#charisma_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.charisma_modifier).to be_zero
    end
  end
end
