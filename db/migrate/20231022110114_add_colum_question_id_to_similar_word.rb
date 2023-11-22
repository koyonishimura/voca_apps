class AddColumQuestionIdToSimilarWord < ActiveRecord::Migration[7.0]
  def change
    add_column :similar_words, :question_id, :integer
  end
end
