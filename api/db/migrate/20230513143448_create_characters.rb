class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.integer :strength, default: 10
      t.integer :dexterity, default: 10
      t.integer :constitution, default: 10
      t.integer :intelligence, default: 10
      t.integer :wisdom, default: 10
      t.integer :charisma, default: 10
      t.integer :base_ac, default: 10
      t.boolean :inspiration, null: false, default: false

      t.timestamps
    end
  end
end
