class Character < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }

  %i[strength dexterity constitution intelligence wisdom charisma].each do |attribute|
    define_method("#{attribute}_modifier") do
      (public_send(attribute) - 10) / 2
    end
  end

  def ac
    base_ac + constitution_modifier
  end

  def inspired?
    inspiration
  end
end
