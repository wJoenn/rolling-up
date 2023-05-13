require "rails_helper"

def test_wrong_character(params)
  wrong_character = Character.create(params)
  expect(wrong_character.persisted?).to be_falsy
end

RSpec.describe Character, type: :model do
  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:name) { "Joenn" }
  let!(:character) { Character.create(name:, user:) }

  describe "validations" do
    it "requires a name and a user" do
      expect(character.persisted?).to be_truthy

      test_wrong_character(name:)
      test_wrong_character(user:)
    end

    it "cannot have a str, dex, con, int, ws or cha smaller than 0 or bigger than 20" do
      test_wrong_character(name:, user:, strength: -1)
      test_wrong_character(name:, user:, strength: 21)

      test_wrong_character(name:, user:, dexterity: -1)
      test_wrong_character(name:, user:, dexterity: 21)

      test_wrong_character(name:, user:, constitution: -1)
      test_wrong_character(name:, user:, constitution: 21)

      test_wrong_character(name:, user:, intelligence: -1)
      test_wrong_character(name:, user:, intelligence: 21)

      test_wrong_character(name:, user:, wisdom: -1)
      test_wrong_character(name:, user:, wisdom: 21)

      test_wrong_character(name:, user:, charisma: -1)
      test_wrong_character(name:, user:, charisma: 21)
    end

    it "has a default value of false for inspiration" do
      expect(character.inspired?).to be_falsy
    end

    it "has a default value of 10 for its stats" do
      expect(character.base_ac).to eq(10)
      expect(character.strength).to eq(10)
      expect(character.dexterity).to eq(10)
      expect(character.constitution).to eq(10)
      expect(character.intelligence).to eq(10)
      expect(character.wisdom).to eq(10)
      expect(character.charisma).to eq(10)
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
      expect(character.ac).to eq(12)
    end
  end

  describe "#strength_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.strength_modifier).to eq(0)
    end
  end

  describe "#dexterity_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.dexterity_modifier).to eq(0)
    end
  end

  describe "#constitution_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.constitution_modifier).to eq(0)
    end
  end

  describe "#intelligence_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.intelligence_modifier).to eq(0)
    end
  end

  describe "#wisdom_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.wisdom_modifier).to eq(0)
    end
  end

  describe "#charisma_modifier" do
    it "returns 0 with a parameter of 10" do
      expect(character.charisma_modifier).to eq(0)
    end
  end
end
