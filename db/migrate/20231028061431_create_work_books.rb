class CreateWorkBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :work_books do |t|
      t.integer :question_id
      t.string :answer
      t.integer :two_question_id
      t.integer :three_question_id

      t.timestamps
    end
  end
end