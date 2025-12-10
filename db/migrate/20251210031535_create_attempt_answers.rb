class CreateAttemptAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :attempt_answers do |t|
      t.references :attempt, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :option, foreign_key: { to_table: :options }
      t.text :text_answer
      t.boolean :correct
      t.timestamps
    end
  end
end
