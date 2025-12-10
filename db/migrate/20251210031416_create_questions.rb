class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.text :prompt, null: false
      t.integer :question_type, default: 0, null: false
      t.timestamps
    end
  end
end
