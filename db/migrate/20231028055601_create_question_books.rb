class CreateQuestionBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :question_books do |t|
      t.integer :score
      t.timestamps
    end
  end
end
