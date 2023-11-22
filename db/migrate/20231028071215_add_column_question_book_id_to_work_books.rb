class AddColumnQuestionBookIdToWorkBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :work_books, :question_book_id, :integer
  end
end
