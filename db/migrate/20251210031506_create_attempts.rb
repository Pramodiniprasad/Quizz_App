class CreateAttempts < ActiveRecord::Migration[8.0]
  def change
    create_table :attempts do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :taker_name
      t.integer :score, default: 0
      t.timestamps
    end
  end
end
