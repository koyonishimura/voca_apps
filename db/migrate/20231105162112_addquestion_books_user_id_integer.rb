class AddquestionBooksUserIdInteger < ActiveRecord::Migration[7.0]
  def change
    add_column :question_books, :user_id, :integer
  end
end
